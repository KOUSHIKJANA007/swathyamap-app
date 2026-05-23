import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swasthyamap/core/error/api_response.dart';
import 'package:swasthyamap/core/error/failure.dart';
import 'package:swasthyamap/core/services/auth_service/auth_session_service.dart';
import 'package:swasthyamap/core/usecases/usecase.dart';
import 'package:swasthyamap/feature/auth/domain/entities/login_response_dto.dart';
import 'package:swasthyamap/feature/auth/domain/entities/user.dart';
import 'package:swasthyamap/feature/auth/domain/usecases/do_login_use_case.dart';
import 'package:swasthyamap/feature/auth/domain/usecases/find_logged_in_user_use_case.dart';

import '../../data/model/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final DoLoginUseCase doLoginUseCase;
  final FindLoggedInUserUseCase findLoggedInUserUseCase;
  final AuthSessionService authSessionService;
  AuthBloc({required this.doLoginUseCase, required this.findLoggedInUserUseCase, required this.authSessionService}) : super(AuthState()) {
    on<AuthFindLoggedInUser>(findLoggedInUser);
    on<AuthLogin>(doLogin);
    on<AuthLogout>(logout);
  }

  void findLoggedInUser(AuthFindLoggedInUser event,Emitter<AuthState> emit)async{
    final userInfo = await authSessionService.getCurrentUser();

    emit(state.copyWith(currentUser: userInfo));

    final resp = await findLoggedInUserUseCase(NoParams());
    resp.fold((failure) {}, (user) {

      emit(state.copyWith(currentUser: user));
      authSessionService.saveUserInfo(UserModel.fromEntity(user));
    });
  }

  void doLogin(AuthLogin event,Emitter<AuthState> emit)async{
    emit(state.copyWith(loginData: ApiResponse.loading()));

    final resp = await doLoginUseCase(DoLoginParams(userName: event.userName, password: event.password));
    await resp.fold((failure) {
      if(failure is ServerFailure){
        emit(state.copyWith(loginData: ApiResponse.error(failure.message)));
      }
    }, (loginData) async{
      await Future.wait([
        authSessionService.saveUserInfo(
          UserModel.fromEntity(loginData.user),
        ),
        authSessionService.saveAccessToken(
          loginData.accessToken,
        ),
        authSessionService.saveRefreshToken(
          loginData.refreshToken,
        ),
      ]);
      emit(state.copyWith(currentUser: loginData.user,loginData: ApiResponse.completed(loginData)));
    });
  }

  void logout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLogout: true));
    await authSessionService.removeAllData();
    emit(state.copyWith(isLogout: false,loginData: ApiResponse.init(),currentUser: null));
  }
}
