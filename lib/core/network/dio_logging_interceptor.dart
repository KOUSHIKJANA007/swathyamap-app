import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';


class DioLoggingInterceptor implements Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('┌── REQUEST ───────────────────────────────────');
    debugPrint('│ ${options.method} ${options.uri}');
    debugPrint('│ Headers : ${options.headers}');
    if (options.data != null) debugPrint('│ Body    : ${options.data}');
    if (options.queryParameters.isNotEmpty) {
      debugPrint('│ Params  : ${options.queryParameters}');
    }
    debugPrint('└──────────────────────────────────────────────');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('┌── RESPONSE ──────────────────────────────────');
    debugPrint('│ ${response.statusCode} ${response.requestOptions.uri}');
    debugPrint('│ Body : ${response.data}');
    debugPrint('└──────────────────────────────────────────────');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('┌── ERROR ─────────────────────────────────────');
    debugPrint('│ ${err.type} ${err.requestOptions.uri}');
    debugPrint('│ Message  : ${err.message}');
    debugPrint('│ Response : ${err.response?.data}');
    debugPrint('└──────────────────────────────────────────────');
    handler.next(err);
  }
}