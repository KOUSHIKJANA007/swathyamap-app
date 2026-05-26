part of 'institute_bloc.dart';

sealed class InstituteState extends Equatable {
  const InstituteState();
  @override
  List<Object> get props => [];
}

final class InstituteInitial extends InstituteState {}
final class InstituteLoading extends InstituteState {}

final class InstituteLoaded extends InstituteState {
  final List<InstituteResDto> institutes;
  const InstituteLoaded({required this.institutes});

  @override
  List<Object> get props => [institutes];
}

final class InstituteCreated extends InstituteState {
  final InstituteResDto institute;
  const InstituteCreated({required this.institute});

  @override
  List<Object> get props => [institute];
}



final class InstituteError extends InstituteState {
  final String message;
  const InstituteError({required this.message});
   @override
  List<Object> get props => [message];
}
