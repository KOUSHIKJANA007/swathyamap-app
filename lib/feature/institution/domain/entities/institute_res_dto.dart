import 'package:equatable/equatable.dart';

class InstituteResDto extends Equatable {
  final String id;
  final String name;
  final String type;
  final String description;
  final String phone;
  final String email;
  final String logo;
  final String banner;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final bool verified;
  final bool active;
  final int totalDoctor;

  const InstituteResDto({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.phone,
    required this.email,
    required this.logo,
    required this.banner,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.verified,
    required this.active,
    required this.totalDoctor,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    type,
    description,
    phone,
    email,
    logo,
    banner,
    address,
    city,
    state,
    postalCode,
    verified,
    active,
    totalDoctor
  ];
}
