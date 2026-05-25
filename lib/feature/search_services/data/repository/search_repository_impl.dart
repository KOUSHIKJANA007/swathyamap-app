import 'package:dartz/dartz.dart';
import 'package:swasthyamap/core/error/exceptions.dart';
import 'package:swasthyamap/core/error/failure.dart';
import 'package:swasthyamap/feature/search_services/data/datasource/search_remote_datasource.dart';
import 'package:swasthyamap/feature/search_services/domain/entities/doctor_search_res_dto.dart';
import 'package:swasthyamap/feature/search_services/domain/repository/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository{
  final SearchRemoteDatasource datasource;
  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<DoctorSearchResDto>>> searchDoctors(Map<String, dynamic> data)async {
    try{
      final resp = await datasource.searchDoctors(data);
      return right(resp);
    }on ServerException catch(e){
      return left(ServerFailure(e.message));
    }
  }

}