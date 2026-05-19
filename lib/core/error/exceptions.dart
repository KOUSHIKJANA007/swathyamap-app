import 'failure.dart';

abstract class AppException implements Exception {
  final String message;
  final int? statusCode;
  final String? errorCode;
  final dynamic data;

  const AppException({
    required this.message,
    this.statusCode,
    this.errorCode,
    this.data,
  });

  @override
  String toString() =>
      '$runtimeType(message: $message, statusCode: $statusCode, errorCode: $errorCode)';
}

class ServerException extends AppException {
  const ServerException(
      String message, {
        super.statusCode,
        super.errorCode,
        super.data,
      }) : super(
    message: message,
  );

  // ✅ factory constructors for common HTTP errors
  factory ServerException.unauthorized(String? message) => ServerException(
    message ??'Unauthorized access. Please login again.',
    statusCode: 401,
    errorCode: 'UNAUTHORIZED',
  );

  factory ServerException.forbidden() => const ServerException(
    'You do not have permission to perform this action.',
    statusCode: 403,
    errorCode: 'FORBIDDEN',
  );

  factory ServerException.notFound() => const ServerException(
    'The requested resource was not found.',
    statusCode: 404,
    errorCode: 'NOT_FOUND',
  );

  factory ServerException.internalServerError() => const ServerException(
    'An internal server error occurred. Please try again later.',
    statusCode: 500,
    errorCode: 'INTERNAL_SERVER_ERROR',
  );

  factory ServerException.noInternet() => const ServerException(
    'No internet connection. Please check your network.',
    statusCode: 503,
    errorCode: 'NO_INTERNET',
  );

  factory ServerException.timeout() => const ServerException(
    'Request timed out. Please try again.',
    statusCode: 408,
    errorCode: 'TIMEOUT',
  );

  factory ServerException.badRequest([String? message]) => ServerException(
    message ?? 'Bad request.',
    statusCode: 400,
    errorCode: 'BAD_REQUEST',
  );

  // ✅ factory from status code
  factory ServerException.fromStatusCode(int statusCode, [String? message]) {
    switch (statusCode) {
      case 400:
        return ServerException.badRequest(message);
      case 401:
        return ServerException.unauthorized(message);
      case 403:
        return ServerException.forbidden();
      case 404:
        return ServerException.notFound();
      case 408:
        return ServerException.timeout();
      case 500:
        return ServerException.internalServerError();
      case 503:
        return ServerException.noInternet();
      default:
        return ServerException(
          message ?? 'An unexpected error occurred.',
          statusCode: statusCode,
          errorCode: 'UNKNOWN_ERROR',
        );
    }
  }

  // ✅ convert to ServerFailure
  ServerFailure toFailure() => ServerFailure(
    message,
    statusCode: statusCode,
    errorCode: errorCode,
  );

  @override
  String toString() =>
      'ServerException(message: $message, statusCode: $statusCode, errorCode: $errorCode)';
}

class CacheException extends AppException {
  const CacheException({
    super.message = 'Cache error occurred.',
    String? errorCode,
    super.data,
  }) : super(
    errorCode: errorCode ?? 'CACHE_ERROR',
  );

  factory CacheException.notFound() => const CacheException(
    message: 'No cached data found.',
    errorCode: 'CACHE_NOT_FOUND',
  );

  factory CacheException.expired() => const CacheException(
    message: 'Cached data has expired.',
    errorCode: 'CACHE_EXPIRED',
  );

  factory CacheException.writeFailed() => const CacheException(
    message: 'Failed to write to cache.',
    errorCode: 'CACHE_WRITE_FAILED',
  );

  factory CacheException.readFailed() => const CacheException(
    message: 'Failed to read from cache.',
    errorCode: 'CACHE_READ_FAILED',
  );

  // ✅ convert to CacheFailure
  CacheFailure toFailure() => CacheFailure(
    message: message,
    errorCode: errorCode,
  );

  @override
  String toString() =>
      'CacheException(message: $message, errorCode: $errorCode)';
}

class InvalidCredentialException extends AppException {
  const InvalidCredentialException({
    super.message = 'Invalid credentials provided.',
    String? errorCode,
    super.data,
  }) : super(
    errorCode: errorCode ?? 'INVALID_CREDENTIALS',
  );

  factory InvalidCredentialException.emailNotFound() =>
      const InvalidCredentialException(
        message: 'No account found with this email.',
        errorCode: 'EMAIL_NOT_FOUND',
      );

  factory InvalidCredentialException.wrongPassword() =>
      const InvalidCredentialException(
        message: 'Incorrect password.',
        errorCode: 'WRONG_PASSWORD',
      );

  factory InvalidCredentialException.accountDisabled() =>
      const InvalidCredentialException(
        message: 'This account has been disabled.',
        errorCode: 'ACCOUNT_DISABLED',
      );

  factory InvalidCredentialException.accountLocked() =>
      const InvalidCredentialException(
        message: 'This account has been locked. Please contact support.',
        errorCode: 'ACCOUNT_LOCKED',
      );

  // ✅ convert to InvalidCredentialFailure
  InvalidCredentialFailure toFailure() => InvalidCredentialFailure(
    message: message,
    errorCode: errorCode,
  );

  @override
  String toString() =>
      'InvalidCredentialException(message: $message, errorCode: $errorCode)';
}

class NetworkException extends AppException {
  const NetworkException({
    super.message = 'A network error occurred.',
    super.statusCode,
    String? errorCode,
    super.data,
  }) : super(
    errorCode: errorCode ?? 'NETWORK_ERROR',
  );

  factory NetworkException.noConnection() => const NetworkException(
    message: 'No internet connection.',
    errorCode: 'NO_CONNECTION',
  );

  factory NetworkException.timeout() => const NetworkException(
    message: 'Connection timed out.',
    errorCode: 'CONNECTION_TIMEOUT',
  );

  // ✅ convert to NetworkFailure
  NetworkFailure toFailure() => NetworkFailure(
    message: message,
    statusCode: statusCode,
    errorCode: errorCode,
  );

  @override
  String toString() =>
      'NetworkException(message: $message, errorCode: $errorCode)';
}