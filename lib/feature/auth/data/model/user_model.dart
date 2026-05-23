import 'package:swasthyamap/core/utils/data_parse_helper/data_parse_helper.dart';
import 'package:swasthyamap/feature/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.phone,
    required super.enabled,
    required super.roles,
    required super.firstName,
    required super.lastName,
  });


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'enabled': enabled,
      'roles': roles,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'].toString()??'',
      firstName: map['firstName'].toString()??'',
      lastName: map['lastName'].toString()??'',
      email: map['email'].toString()??'',
      phone: map['phone'].toString()??'',
      enabled: map['enabled'] == true,
      roles: DataParseHelper.safeList(map['roles'],parser: (e)=>e.toString()),
    );
  }

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    bool? enabled,
    List<String>? roles,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      enabled: enabled ?? this.enabled,
      roles: roles ?? this.roles,
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      phone: user.phone,
      enabled: user.enabled,
      roles: user.roles,
    );
  }


}
