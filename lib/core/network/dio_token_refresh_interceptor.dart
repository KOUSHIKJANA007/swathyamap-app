import 'package:dio/dio.dart';
import '../services/auth_service/auth_session_service.dart';


class _PendingRequest {
  final RequestOptions options;
  final ErrorInterceptorHandler handler;
  _PendingRequest(this.options, this.handler);
}

class DioTokenRefreshInterceptor extends Interceptor {
  final AuthSessionService authSessionService;
  final Dio dio;
  bool _isRefreshing = false;
  final List<_PendingRequest> _pendingRequests = [];

  DioTokenRefreshInterceptor({
    required this.authSessionService,
    required this.dio,
  });

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {

    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    // Avoid refresh loop on the refresh endpoint itself
    if (err.requestOptions.path.contains('/auth/refreshToken')) {
      return handler.next(err);
    }

    if (_isRefreshing) {
      _pendingRequests.add(_PendingRequest(err.requestOptions, handler));
      return;
    }

    _isRefreshing = true;

    try {
      final refreshToken = await authSessionService.getRefreshToken();
      final accessToken = await authSessionService.getAccessToken();
      final userInfo = await authSessionService.getCurrentUser();
      if (refreshToken.isEmpty) {
        _rejectAllPending(err);
        return handler.next(err);
      }

      var userInfoForToken={
        'userId': userInfo?.id,
        'userName': userInfo?.email,
        'accessToken': accessToken,
        'refreshToken': refreshToken
      };

      final refreshResponse = await dio.post(
        '/auth/refreshToken',
        data: userInfoForToken
      );

      final newAccessToken = refreshResponse.data['accessToken']?.toString() ?? '';
      await authSessionService.saveAccessToken(newAccessToken);

      // Retry all queued requests with new token
      for (final pending in _pendingRequests) {
        pending.options.headers['Authorization'] = 'Bearer $newAccessToken';
        try {
          final retryResponse = await dio.fetch(pending.options);
          pending.handler.resolve(retryResponse);
        } catch (e) {
          pending.handler.next(
            DioException(requestOptions: pending.options, error: e),
          );
        }
      }
      _pendingRequests.clear();

      // Retry original failed request
      err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
      final retryResponse = await dio.fetch(err.requestOptions);
      handler.resolve(retryResponse);
    } catch (_) {
      _rejectAllPending(err);
      await authSessionService.removeAllData();
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  void _rejectAllPending(DioException err) {
    for (final pending in _pendingRequests) {
      pending.handler.next(
        DioException(requestOptions: pending.options, error: err),
      );
    }
    _pendingRequests.clear();
  }
}