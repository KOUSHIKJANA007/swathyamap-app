import 'package:dartz/dartz.dart';
import 'package:swasthyamap/core/error/failure.dart';
import 'package:swasthyamap/feature/auth/domain/entities/user.dart';

import '../entities/login_response_dto.dart';

abstract class AuthRepository {
  Future<Either<Failure,LoginResponseDto>> login(Map<String, dynamic> data);
  Future<Either<Failure,User>> findCurrentLoggedInUser();
}