part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}
final class SearchLoading extends SearchState {}
final class SearchLoaded extends SearchState {
  final List<DoctorSearchResDto> doctors;
  final bool hasMoreDoctor;
  final bool moreDoctorLoading;

  const SearchLoaded({
    this.doctors = const [],
    this.hasMoreDoctor = true,
    this.moreDoctorLoading = false
  });

  @override
  List<Object> get props => [doctors];

  SearchLoaded copyWith({
    List<DoctorSearchResDto>? doctors,
    bool? hasMoreDoctor,
    bool? moreDoctorLoading,
  }) {
    return SearchLoaded(
      doctors: doctors ?? this.doctors,
      hasMoreDoctor: hasMoreDoctor ?? this.hasMoreDoctor,
      moreDoctorLoading: moreDoctorLoading ?? this.moreDoctorLoading,
    );
  }
}
final class SearchError extends SearchState {
  final String message;
  const SearchError({required this.message});
  @override
  List<Object> get props => [message];
}
