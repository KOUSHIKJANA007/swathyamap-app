import 'package:swasthyamap/core/utils/data_parse_helper/data_parse_helper.dart';
import 'package:swasthyamap/feature/institution/domain/entities/institute_res_dto.dart';

class InstituteResDtoModel extends InstituteResDto {
  const InstituteResDtoModel({
    required super.id,
    required super.name,
    required super.type,
    required super.description,
    required super.phone,
    required super.email,
    required super.logo,
    required super.banner,
    required super.address,
    required super.city,
    required super.state,
    required super.postalCode,
    required super.verified,
    required super.active,
    required super.totalDoctor,
  });

  InstituteResDtoModel copyWith({
    String? id,
    String? name,
    String? type,
    String? description,
    String? phone,
    String? email,
    String? logo,
    String? banner,
    String? address,
    String? city,
    String? state,
    String? postalCode,
    bool? verified,
    bool? active,
    int? totalDoctor,
  }) {
    return InstituteResDtoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      logo: logo ?? this.logo,
      banner: banner ?? this.banner,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      verified: verified ?? this.verified,
      active: active ?? this.active,
      totalDoctor: totalDoctor ?? this.totalDoctor,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'description': description,
      'phone': phone,
      'email': email,
      'logo': logo,
      'banner': banner,
      'address': address,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'verified': verified,
      'active': active,
      'totalDoctor': totalDoctor,
    };
  }

  factory InstituteResDtoModel.fromJson(Map<String, dynamic> map) {
    return InstituteResDtoModel(
      id: map['id']?.toString()??'',
      name: map['name']?.toString()??'',
      type: map['type']?.toString()??'',
      description: map['description']?.toString()??'',
      phone: map['phone']?.toString()??'',
      email: map['email']?.toString()??'',
      logo: map['logo']?.toString()??'',
      banner: map['banner']?.toString()??'',
      address: map['address']?.toString()??'',
      city: map['city']?.toString()??'',
      state: map['state']?.toString()??'',
      postalCode: map['postalCode']?.toString()??'',
      verified: map['verified'] == true,
      active: map['active'] == true,
      totalDoctor: DataParseHelper.safeInt(map['totalDoctor']),
    );
  }
}
