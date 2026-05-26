import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swasthyamap/core/error/api_response.dart';
import 'package:swasthyamap/core/error/failure.dart';
import 'package:swasthyamap/feature/institution/domain/entities/institute_res_dto.dart';
import 'package:swasthyamap/feature/institution/domain/usecases/create_institute_use_case.dart';
import 'package:swasthyamap/feature/institution/domain/usecases/find_institutes_by_owner_use_case.dart';

part 'institute_event.dart';

part 'institute_state.dart';

class InstituteBloc extends Bloc<InstituteEvent, InstituteState> {
  final FindInstitutesByOwnerUseCase findInstitutesByOwnerUseCase;
  final CreateInstituteUseCase createInstituteUseCase;

  InstituteBloc({
    required this.findInstitutesByOwnerUseCase,
    required this.createInstituteUseCase,
  }) : super(InstituteInitial()) {
    on<FindInstitutesForOwner>(findInstitutesForOwner);
    on<CreateInstitute>(createInstitute);
  }

  void findInstitutesForOwner(FindInstitutesForOwner event,
      Emitter<InstituteState> emit,) async {
    emit(InstituteLoading());
    final resp = await findInstitutesByOwnerUseCase(
      FindInstitutesByOwnerParams(
        userId: event.userId,
        pageNumber: event.pageNumber,
        pageSize: event.pageSize,
        searchKey: event.searchKey,
      ),
    );

    resp.fold((l) {
      if (l is ServerFailure) {
        emit(InstituteError(message: l.message));
      }
    }, (data) => emit(InstituteLoaded(institutes: data)));
  }

  void createInstitute(CreateInstitute event,
      Emitter<InstituteState> emit) async {
    emit(InstituteLoading());
    final resp = await createInstituteUseCase(CreateInstituteParams(name: event.name,
        type: event.type,
        description: event.description,
        phone: event.phone,
        email: event.email,
        address: event.address,
        city: event.city,
        state: event.state,
        postalCode: event.postalCode,
        latitude: event.latitude,
        longitude: event.longitude,
        image: event.image,
        ownerUserId: event.ownerUserId
    ));

    resp.fold((l) {
      if (l is ServerFailure) {
        emit(InstituteError(message: l.message));
      }
    }, (data) => emit(InstituteCreated(institute: data)));
  }
}
