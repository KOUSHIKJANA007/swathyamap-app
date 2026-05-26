import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:swasthyamap/core/error/failure.dart';
import 'package:swasthyamap/core/usecases/usecase.dart';
import 'package:swasthyamap/feature/institution/domain/entities/institute_res_dto.dart';
import 'package:swasthyamap/feature/institution/domain/repository/institute_repository.dart';

class CreateInstituteUseCase extends UseCase<InstituteResDto,CreateInstituteParams>{
  final InstituteRepository repository;

  CreateInstituteUseCase(this.repository);

  @override
  Future<Either<Failure, InstituteResDto>> call(CreateInstituteParams params)async {
    Map<String,dynamic> data={
     'name': params.name,
     'ownerUserId': params.ownerUserId,
     'type': params.type,
     'description': params.description,
     'phone':params.phone,
     'email': params.email,
     'address': params.address,
     'city': params.city,
     'state': params.state,
     'postalCode': params.postalCode,
      'location': {
        'latitude': params.latitude,
        'longitude': params.longitude
      }
    };

    final formData = FormData.fromMap({
      'data': jsonEncode(data),
      if (params.image != null)
        'image': await MultipartFile.fromFile(
          params.image!.path,
          filename: params.image!.path.split('/').last,
        ),
    });
    return await repository.createInstitute(formData);
  }
}

class CreateInstituteParams extends Equatable {
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

  const CreateInstituteParams({
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
    ownerUserId,
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
    image
  ];
}
