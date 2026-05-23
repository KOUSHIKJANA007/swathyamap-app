import 'package:dartz/dartz.dart';
import 'package:swasthyamap/core/error/failure.dart';
import 'package:swasthyamap/core/usecases/usecase.dart';
import 'package:swasthyamap/feature/auth/domain/entities/user.dart';
import 'package:swasthyamap/feature/auth/domain/repository/auth_repository.dart';

class FindLoggedInUserUseCase extends UseCase<User,NoParams>{
  final AuthRepository authRepository;
  FindLoggedInUserUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params)async {
    return await authRepository.findCurrentLoggedInUser();
  }
}
