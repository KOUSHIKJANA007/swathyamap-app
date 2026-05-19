import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../services/auth_service/auth_session_service.dart';
import 'dio_helper.dart';
import 'dio_logging_interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  final Dio _dio;
  final AuthSessionService _authSessionService;
  final DioLoggingInterceptor dioLoggingInterceptor;

  DioClient({
    required Dio dio,
    required AuthSessionService authSessionService,
    required this.dioLoggingInterceptor,
  }) : _dio = dio,
       _authSessionService = authSessionService {
    _dio.options = BaseOptions(
      baseUrl: dotenv.get('APP_BASE_URL'),
      connectTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 30),
      receiveDataWhenStatusError: true,
      contentType: 'application/json',
      responseType: ResponseType.json,
    );


    _dio.interceptors.add(dioLoggingInterceptor);
  }

  // ── Auth header ────────────────────────────────────────────────────────────

  Future<Options> _buildOptions({
    bool isAuthRequired = true,
    Options? extraOptions,
  }) async {
    final base = extraOptions ?? Options();
    if (!isAuthRequired) return base;

    final token = await _authSessionService.getAccessToken();
    return base.copyWith(
      headers: {
        ...?base.headers,
        if (token.isNotEmpty) 'Authorization': 'Bearer $token',
      },
    );
  }

  // ── GET ────────────────────────────────────────────────────────────────────

  Future<T> get<T>({
    required String url,
    Map<String, dynamic>? queryParameters,
    bool isAuthRequired = true,
    Options? options,
  }) async {
    try {
      final opts = await _buildOptions(
        isAuthRequired: isAuthRequired,
        extraOptions: options,
      );
      final response = await _dio.get<T>(
        url,
        queryParameters: queryParameters,
        options: opts,
      );
      return response.data as T;
    } catch (e) {
      throw mapException(e);
    }
  }

  // ── POST ───────────────────────────────────────────────────────────────────

  Future<T> post<T>({
    required String url,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isAuthRequired = true,
    Options? options,
  }) async {
    try {
      final opts = await _buildOptions(
        isAuthRequired: isAuthRequired,
        extraOptions: options,
      );
      final response = await _dio.post<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: opts,
      );
      return response.data as T;
    } catch (e) {
      throw mapException(e);
    }
  }

  // ── PUT ────────────────────────────────────────────────────────────────────

  Future<T> put<T>({
    required String url,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isAuthRequired = true,
    Options? options,
  }) async {
    try {
      final opts = await _buildOptions(
        isAuthRequired: isAuthRequired,
        extraOptions: options,
      );
      final response = await _dio.put<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: opts,
      );
      return response.data as T;
    } catch (e) {
      throw mapException(e);
    }
  }

  // ── PATCH ──────────────────────────────────────────────────────────────────

  Future<T> patch<T>({
    required String url,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isAuthRequired = true,
    Options? options,
  }) async {
    try {
      final opts = await _buildOptions(
        isAuthRequired: isAuthRequired,
        extraOptions: options,
      );
      final response = await _dio.patch<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: opts,
      );
      return response.data as T;
    } catch (e) {
      throw mapException(e);
    }
  }

  // ── DELETE ─────────────────────────────────────────────────────────────────

  Future<T> delete<T>({
    required String url,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isAuthRequired = true,
    Options? options,
  }) async {
    try {
      final opts = await _buildOptions(
        isAuthRequired: isAuthRequired,
        extraOptions: options,
      );
      final response = await _dio.delete<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: opts,
      );
      return response.data as T;
    } catch (e) {
      throw mapException(e);
    }
  }

  // ── MULTIPART / FILE UPLOAD ────────────────────────────────────────────────
  Future<T> upload<T>({
    required String url,
    required FormData formData,
    required String method, // "POST", "PUT", "PATCH"
    bool isAuthRequired = true,
    void Function(int sent, int total)? onSendProgress,
  }) async {
    try {
      final opts = await _buildOptions(isAuthRequired: isAuthRequired);

      late Response<T> response;

      switch (method.toUpperCase()) {
        case "POST":
          response = await _dio.post<T>(
            url,
            data: formData,
            options: opts,
            onSendProgress: onSendProgress,
          );
          break;

        case "PUT":
          response = await _dio.put<T>(
            url,
            data: formData,
            options: opts,
            onSendProgress: onSendProgress,
          );
          break;

        case "PATCH":
          response = await _dio.patch<T>(
            url,
            data: formData,
            options: opts,
            onSendProgress: onSendProgress,
          );
          break;

        default:
          throw Exception("Unsupported HTTP method: $method");
      }

      return response.data as T;
    } catch (e) {
      throw mapException(e);
    }
  }

}
