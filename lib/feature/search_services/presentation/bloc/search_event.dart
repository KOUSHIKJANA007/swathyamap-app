part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object?> get props => [];
}

class SearchDoctor extends SearchEvent{
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

  const SearchDoctor({
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
