import 'package:dartz/dartz.dart';
import 'package:swasthyamap/core/error/exceptions.dart';
import 'package:swasthyamap/core/error/failure.dart';
import 'package:swasthyamap/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:swasthyamap/feature/auth/domain/entities/login_response_dto.dart';
import 'package:swasthyamap/feature/auth/domain/entities/user.dart';
import 'package:swasthyamap/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDatasource _datasource;
  AuthRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, User>> findCurrentLoggedInUser() async{
    try{
      final resp = await _datasource.findCurrentLoggedInUser();
      return right(resp);
    }on ServerException catch(e){
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, LoginResponseDto>> login(Map<String, dynamic> data) async{
    try{
      final resp = await _datasource.login(data);
      return right(resp);
    }on ServerException catch(e){
      return left(ServerFailure(e.message));
    }
  }

}