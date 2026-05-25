import 'package:dartz/dartz.dart';
import 'package:swasthyamap/core/error/failure.dart';

import '../entities/doctor_search_res_dto.dart';

abstract class SearchRepository {
  Future<Either<Failure,List<DoctorSearchResDto>>> searchDoctors(Map<String, dynamic> data);
}