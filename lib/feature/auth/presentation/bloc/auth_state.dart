part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final User? currentUser;
  final ApiResponse<LoginResponseDto> loginData;
  final bool isLogout;
  const AuthState({
     this.currentUser,
     this.loginData = const ApiResponse.init(),
    this.isLogout = false
  });

  @override
  List<Object?> get props => [?currentUser,loginData,isLogout];

  AuthState copyWith({
    User? currentUser,
    ApiResponse<LoginResponseDto>? loginData,
    bool? isLogout,
  }) {
    return AuthState(
      currentUser: currentUser ?? this.currentUser,
      loginData: loginData ?? this.loginData,
      isLogout: isLogout ?? this.isLogout,
    );
  }

}