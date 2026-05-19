import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final bool enabled;
  final List<String> roles;

  const User({
    required this.id,
    required this.email,
    required this.phone,
    required this.enabled,
    required this.roles,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object?> get props => [id,firstName,lastName,email,phone,enabled,roles];

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    bool? enabled,
    List<String>? roles,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      enabled: enabled ?? this.enabled,
      roles: roles ?? this.roles,
    );
  }
}
