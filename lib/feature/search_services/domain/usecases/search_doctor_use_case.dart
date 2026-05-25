import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:swasthyamap/core/error/failure.dart';
import 'package:swasthyamap/core/usecases/usecase.dart';
import 'package:swasthyamap/feature/search_services/domain/entities/doctor_search_res_dto.dart';
import 'package:swasthyamap/feature/search_services/domain/repository/search_repository.dart';

class SearchDoctorUseCase
    extends UseCase<List<DoctorSearchResDto>, SearchDoctorParams> {
  final SearchRepository repository;

  SearchDoctorUseCase(this.repository);

  @override
  Future<Either<Failure, List<DoctorSearchResDto>>> call(SearchDoctorParams params) async {
    Map<String, dynamic> data = {
      'latitude': params.latitude,
      'longitude': params.longitude,
      'search': params.search,
      'specialization': params.specialization,
      'dayOfWeek': params.dayOfWeek,
      'availableAt': params.availableAt,
      'radiusKm': params.radiusKm,
      'lastDistance': params.lastDistance,
      'lastDoctorId': params.lastDoctorId,
      'limit': params.limit,
      'institutionType': params.institutionType,
      'availableNowOnly': params.availableNowOnly,
    };

    return await repository.searchDoctors(data);
  }
}

class SearchDoctorParams extends Equatable {
  final double latitude;
  final double longitude;
  final String search;
  final List<String> specialization;
  final String dayOfWeek;
  final DateTime? availableAt;
  final double radiusKm;
  final double lastDistance;
  final String? lastDoctorId;
  final int limit;
  final List<String> institutionType;
  final bool availableNowOnly;

  const SearchDoctorParams({
    required this.latitude,
    required this.longitude,
    required this.search,
    required this.specialization,
    required this.dayOfWeek,
    this.availableAt,
    required this.lastDistance,
    this.lastDoctorId,
    required this.limit,
    required this.institutionType,
    required this.availableNowOnly,
    required this.radiusKm,
  });

  @override
  List<Object?> get props => [
    latitude,
    longitude,
    search,
    specialization,
    dayOfWeek,
    availableAt,
    lastDistance,
    lastDoctorId,
    limit,
    institutionType,
    availableNowOnly,
    radiusKm,
  ];
}
