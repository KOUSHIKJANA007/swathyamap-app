import 'package:equatable/equatable.dart';


abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;
  final String? errorCode;

  const Failure({
    required this.message,
    this.statusCode,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, statusCode, errorCode];

  @override
  String toString() => 'Failure(message: $message, statusCode: $statusCode, errorCode: $errorCode)';
}

class ServerFailure extends Failure {
  const ServerFailure(
      String message, {
        super.statusCode,
        super.errorCode,
      }) : super(
    message: message,
  );

  // ✅ factory constructors for common HTTP errors
  factory ServerFailure.unauthorized() => const ServerFailure(
    'Unauthorized access. Please login again.',
    statusCode: 401,
    errorCode: 'UNAUTHORIZED',
  );

  factory ServerFailure.forbidden() => const ServerFailure(
    'You do not have permission to perform this action.',
    statusCode: 403,
    errorCode: 'FORBIDDEN',
  );

  factory ServerFailure.notFound() => const ServerFailure(
    'The requested resource was not found.',
    statusCode: 404,
    errorCode: 'NOT_FOUND',
  );

  factory ServerFailure.internalServerError() => const ServerFailure(
    'An internal server error occurred. Please try again later.',
    statusCode: 500,
    errorCode: 'INTERNAL_SERVER_ERROR',
  );

  factory ServerFailure.noInternet() => const ServerFailure(
    'No internet connection. Please check your network.',
    statusCode: 503,
    errorCode: 'NO_INTERNET',
  );

  factory ServerFailure.timeout() => const ServerFailure(
    'Request timed out. Please try again.',
    statusCode: 408,
    errorCode: 'TIMEOUT',
  );

  // ✅ factory from status code
  factory ServerFailure.fromStatusCode(int statusCode, [String? message]) {
    switch (statusCode) {
      case 401:
        return ServerFailure.unauthorized();
      case 403:
        return ServerFailure.forbidden();
      case 404:
        return ServerFailure.notFound();
      case 408:
        return ServerFailure.timeout();
      case 500:
        return ServerFailure.internalServerError();
      case 503:
        return ServerFailure.noInternet();
      default:
        return ServerFailure(
          message ?? 'An unexpected error occurred.',
          statusCode: statusCode,
          errorCode: 'UNKNOWN_ERROR',
        );
    }
  }

  @override
  String toString() => 'ServerFailure(message: $message, statusCode: $statusCode, errorCode: $errorCode)';
}

class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Cache error occurred.',
    String? errorCode,
  }) : super(
    errorCode: errorCode ?? 'CACHE_ERROR',
  );

  factory CacheFailure.notFound() => const CacheFailure(
    message: 'No cached data found.',
    errorCode: 'CACHE_NOT_FOUND',
  );

  factory CacheFailure.expired() => const CacheFailure(
    message: 'Cached data has expired.',
    errorCode: 'CACHE_EXPIRED',
  );

  factory CacheFailure.writeFailed() => const CacheFailure(
    message: 'Failed to write to cache.',
    errorCode: 'CACHE_WRITE_FAILED',
  );

  @override
  String toString() => 'CacheFailure(message: $message, errorCode: $errorCode)';
}

class InvalidCredentialFailure extends Failure {
  const InvalidCredentialFailure({
    super.message = 'Invalid credentials provided.',
    String? errorCode,
  }) : super(
    errorCode: errorCode ?? 'INVALID_CREDENTIALS',
  );

  factory InvalidCredentialFailure.emailNotFound() =>
      const InvalidCredentialFailure(
        message: 'No account found with this email.',
        errorCode: 'EMAIL_NOT_FOUND',
      );

  factory InvalidCredentialFailure.wrongPassword() =>
      const InvalidCredentialFailure(
        message: 'Incorrect password.',
        errorCode: 'WRONG_PASSWORD',
      );

  factory InvalidCredentialFailure.accountDisabled() =>
      const InvalidCredentialFailure(
        message: 'This account has been disabled.',
        errorCode: 'ACCOUNT_DISABLED',
      );

  @override
  String toString() => 'InvalidCredentialFailure(message: $message, errorCode: $errorCode)';
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'A network error occurred.',
    super.statusCode,
    String? errorCode,
  }) : super(
    errorCode: errorCode ?? 'NETWORK_ERROR',
  );

  factory NetworkFailure.noConnection() => const NetworkFailure(
    message: 'No internet connection.',
    errorCode: 'NO_CONNECTION',
  );

  factory NetworkFailure.timeout() => const NetworkFailure(
    message: 'Connection timed out.',
    errorCode: 'CONNECTION_TIMEOUT',
  );

  @override
  String toString() => 'NetworkFailure(message: $message, errorCode: $errorCode)';
}

