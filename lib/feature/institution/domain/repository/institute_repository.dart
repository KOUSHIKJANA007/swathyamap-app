import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:swasthyamap/core/error/failure.dart';
import 'package:swasthyamap/feature/institution/domain/entities/institute_res_dto.dart';

abstract class InstituteRepository {
  Future<Either<Failure,List<InstituteResDto>>> findAllInstituteByOwner(String userId, int pageSize, int pageNumber, String searchKey);
  Future<Either<Failure,InstituteResDto>> createInstitute(FormData formData);
}