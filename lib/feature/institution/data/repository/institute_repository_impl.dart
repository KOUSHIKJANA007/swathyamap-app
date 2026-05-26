import 'package:dartz/dartz.dart';
import 'package:dio/src/form_data.dart';
import 'package:swasthyamap/core/error/exceptions.dart';
import 'package:swasthyamap/core/error/failure.dart';
import 'package:swasthyamap/feature/institution/data/datasource/institute_remote_datasource.dart';
import 'package:swasthyamap/feature/institution/domain/entities/institute_res_dto.dart';
import 'package:swasthyamap/feature/institution/domain/repository/institute_repository.dart';

class InstituteRepositoryImpl extends InstituteRepository{
  final InstituteRemoteDatasource datasource;
  InstituteRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<InstituteResDto>>> findAllInstituteByOwner(String userId, int pageSize, int pageNumber, String searchKey)async {
    try{
      final resp = await datasource.findAllInstituteByOwner(userId, pageSize, pageNumber, searchKey);
      return right(resp);
    }on ServerException catch(e){
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, InstituteResDto>> createInstitute(FormData formData)async {
    try{
      final resp = await datasource.createInstitute(formData);
      return right(resp);
    }on ServerException catch(e){
      return left(ServerFailure(e.message));
    }
  }

}