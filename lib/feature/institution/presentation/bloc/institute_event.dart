part of 'institute_bloc.dart';

sealed class InstituteEvent extends Equatable {
  const InstituteEvent();

  @override
  List<Object?> get props => [];
}

class FindInstitutesForOwner extends InstituteEvent {
  final String userId;
  final String searchKey;
  final int pageNumber;
  final int pageSize;

  const FindInstitutesForOwner({
    required this.userId,
    required this.searchKey,
    required this.pageNumber,
    required this.pageSize,
  });

  @override
  List<Object?> get props => [userId, searchKey, pageSize, pageNumber];
}

class CreateInstitute extends InstituteEvent{
  final String ownerUserId;
  final String name;
  final String type;
  final String description;
  final String phone;
  final String email;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final double latitude;
  final double longitude;
  final File? image;

  const CreateInstitute({
    required this.name,
    required this.type,
    required this.description,
    required this.phone,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
    this.image, required this.ownerUserId,
  });

  @override
  List<Object?> get props => [
    name,
    type,
    description,
    phone,
    email,
    address,
    city,
    state,
    postalCode,
    latitude,
    longitude,
    image,
    ownerUserId
  ];
}
