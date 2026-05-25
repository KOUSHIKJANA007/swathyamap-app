import 'package:equatable/equatable.dart';

class DoctorSearchResDto extends Equatable {
  final String doctorId;
  final String doctorName;
  final String specialization;
  final String doctorPhone;
  final String doctorEmail;
  final String doctorImage;
  final int experienceYears;
  final String nextAvailableDay;
  final DateTime? nextAvailableStartTime;
  final DateTime? nextAvailableEndTime;
  final String institutionId;
  final String institutionName;
  final String institutionType;

  final String address;
  final String city;
  final String state;
  final String institutionPhone;
  final String institutionEmail;
  final String dayOfWeek;
  final DateTime? startTime;
  final DateTime? endTime;
  final double distanceKm;
  final bool availableNow;

  const DoctorSearchResDto({
    required this.doctorId,
    required this.doctorName,
    required this.specialization,
    required this.doctorPhone,
    required this.doctorEmail,
    required this.doctorImage,
    required this.experienceYears,
    required this.nextAvailableDay,
    this.nextAvailableStartTime,
    this.nextAvailableEndTime,
    required this.institutionId,
    required this.institutionName,
    required this.institutionType,
    required this.address,
    required this.city,
    required this.state,
    required this.institutionPhone,
    required this.institutionEmail,
    required this.dayOfWeek,
    this.startTime,
    this.endTime,
    required this.distanceKm,
    required this.availableNow,
  });

  @override
  List<Object?> get props => [
    doctorId,
    doctorName,
    specialization,
    doctorPhone,
    doctorEmail,
    doctorImage,
    experienceYears,
    nextAvailableDay,
    nextAvailableStartTime,
    nextAvailableEndTime,
    institutionId,
    institutionName,
    institutionType,
    address,
    city,
    state,
    institutionPhone,
    institutionEmail,
    dayOfWeek,
    startTime,
    endTime,
    distanceKm,
    availableNow
  ];

}
