import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swasthyamap/core/error/failure.dart';
import 'package:swasthyamap/feature/search_services/domain/entities/doctor_search_res_dto.dart';
import 'package:swasthyamap/feature/search_services/domain/usecases/search_doctor_use_case.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchDoctorUseCase searchDoctorUseCase;

  SearchBloc({required this.searchDoctorUseCase}) : super(SearchInitial()) {
    on<SearchDoctor>(searchDoctor);
  }

  Future<void> searchDoctor(SearchDoctor event, Emitter<SearchState> emit) async {

    final isPagination = event.lastDoctorId != null;

    List<DoctorSearchResDto> previousDoctors = [];

    if (isPagination) {
      if (state is! SearchLoaded) return;

      final currentState = state as SearchLoaded;

      previousDoctors = currentState.doctors;

      emit(currentState.copyWith(
        moreDoctorLoading: true,
      ));
    } else {
      emit(SearchLoading());
    }

    final resp = await searchDoctorUseCase(
      SearchDoctorParams(
        latitude: event.latitude,
        longitude: event.longitude,
        search: event.search,
        specialization: event.specialization,
        dayOfWeek: event.dayOfWeek,
        lastDistance: event.lastDistance,
        lastDoctorId: event.lastDoctorId,
        limit: event.limit,
        institutionType: event.institutionType,
        availableNowOnly: event.availableNowOnly,
        radiusKm: event.radiusKm,
      ),
    );

    resp.fold(
          (failure) {
        if (failure is ServerFailure) {
          if (isPagination && state is SearchLoaded) {
            final currentState = state as SearchLoaded;

            emit(currentState.copyWith(
              moreDoctorLoading: false,
            ));
          } else {
            emit(SearchError(message: failure.message));
          }
        }
      },
          (data) {

        final hasMoreDoctor = data.length >= event.limit;

        if (!isPagination) {
          emit(SearchLoaded(
            doctors: data,
            hasMoreDoctor: hasMoreDoctor,
          ));
          return;
        }

        final currentState = state as SearchLoaded;

        final existingIds =
        previousDoctors.map((e) => e.doctorId).toSet();

        final uniqueDoctors = data
            .where((e) => !existingIds.contains(e.doctorId))
            .toList();

        final updatedDoctors = [
          ...previousDoctors,
          ...uniqueDoctors,
        ];

        emit(
          currentState.copyWith(
            doctors: updatedDoctors,
            moreDoctorLoading: false,
            hasMoreDoctor: hasMoreDoctor,
          ),
        );
      },
    );
  }
}
