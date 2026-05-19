import 'dart:io';
import 'package:dio/dio.dart';
import '../error/exceptions.dart';


AppException mapException(Object error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException.timeout();

      case DioExceptionType.cancel:
        return const NetworkException(
          message: 'Request was cancelled.',
          errorCode: 'REQUEST_CANCELLED',
        );

      case DioExceptionType.connectionError:
        return NetworkException.noConnection();

      case DioExceptionType.badResponse:
        return _mapStatusCode(error.response);

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return NetworkException.noConnection();
        }
        return NetworkException(
          message: error.message ?? 'An unexpected error occurred.',
        );

      default:
        return NetworkException(
          message: error.message ?? 'An unexpected error occurred.',
        );
    }
  }

  if (error is SocketException) return NetworkException.noConnection();

  // Already one of our app exceptions — pass through as-is
  if (error is AppException) return error;

  return NetworkException(message: error.toString());
}

AppException _mapStatusCode(Response? response) {
  final statusCode = response?.statusCode;
  final data = response?.data;
  final serverMessage = _extractServerMessage(data);

  switch (statusCode) {
    case 400:
      return ServerException.badRequest(serverMessage);
    case 401:
      return ServerException.unauthorized(serverMessage??'Something went wrong!!');
    case 403:
      return ServerException.forbidden();
    case 404:
      return ServerException.notFound();
    case 408:
      return ServerException.timeout();
    case 409:
      return ServerException(
        serverMessage ?? 'Conflict with existing data.',
        statusCode: 409,
        errorCode: 'CONFLICT',
        data: data,
      );
    case 422:
      return ServerException(
        serverMessage ?? 'Validation failed.',
        statusCode: 422,
        errorCode: 'VALIDATION_ERROR',
        data: data,
      );
    case 500:
      return ServerException.internalServerError();
    case 503:
      return ServerException.noInternet();
    default:
      if (statusCode != null && statusCode >= 500) {
        return ServerException(
          serverMessage ?? 'Server error. Please try again later.',
          statusCode: statusCode,
          errorCode: 'SERVER_ERROR',
          data: data,
        );
      }
      return ServerException.fromStatusCode(statusCode ?? 0, serverMessage);
  }
}

String? _extractServerMessage(dynamic data) {
  if (data is Map<String, dynamic>) {
    return data['message'] as String? ??
        data['Message'] as String? ??
        data['error'] as String? ??
        data['detail'] as String?;
  }
  return null;
}
