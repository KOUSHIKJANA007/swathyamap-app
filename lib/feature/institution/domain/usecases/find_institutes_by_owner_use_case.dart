import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:swasthyamap/core/error/failure.dart';
import 'package:swasthyamap/core/usecases/usecase.dart';
import 'package:swasthyamap/feature/institution/domain/entities/institute_res_dto.dart';
import 'package:swasthyamap/feature/institution/domain/repository/institute_repository.dart';

class FindInstitutesByOwnerUseCase extends UseCase<List<InstituteResDto>,FindInstitutesByOwnerParams>{
  final InstituteRepository repository;
  FindInstitutesByOwnerUseCase(this.repository);

  @override
  Future<Either<Failure, List<InstituteResDto>>> call(FindInstitutesByOwnerParams params)async {
    return await repository.findAllInstituteByOwner(params.userId, params.pageSize, params.pageNumber, params.searchKey);
  }

}

class FindInstitutesByOwnerParams extends Equatable{
  final String userId;
  final String searchKey;
  final int pageNumber;
  final int pageSize;
  const FindInstitutesByOwnerParams({required this.userId, required this.searchKey, required this.pageNumber, required this.pageSize});
  @override
  List<Object?> get props => [userId,searchKey,pageSize,pageNumber];
}