part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLogin extends AuthEvent{
  final String userName;
  final String password;

  const AuthLogin({required this.userName, required this.password});

  @override
  List<Object?> get props => [userName, password];
}

class AuthFindLoggedInUser extends AuthEvent{}
class AuthLogout extends AuthEvent{}