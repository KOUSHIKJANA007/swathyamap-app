import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:swasthyamap/core/error/failure.dart';
import 'package:swasthyamap/core/usecases/usecase.dart';
import 'package:swasthyamap/feature/auth/domain/entities/login_response_dto.dart';
import 'package:swasthyamap/feature/auth/domain/repository/auth_repository.dart';

class DoLoginUseCase extends UseCase<LoginResponseDto, DoLoginParams> {
  final AuthRepository repository;


  DoLoginUseCase(this.repository);

  @override
  Future<Either<Failure, LoginResponseDto>> call(DoLoginParams params) async{
    Map<String,dynamic> data ={
     'username': params.userName,
     'password': params.password
    };
    return await repository.login(data);
  }
}

class DoLoginParams extends Equatable {
  final String userName;
  final String password;

  const DoLoginParams({required this.userName, required this.password});

  @override
  List<Object?> get props => [userName, password];
}
