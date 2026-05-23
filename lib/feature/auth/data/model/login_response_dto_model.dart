import 'package:swasthyamap/feature/auth/data/model/user_model.dart';
import 'package:swasthyamap/feature/auth/domain/entities/login_response_dto.dart';

class LoginResponseDtoModel extends LoginResponseDto{
  const LoginResponseDtoModel({required super.accessToken, required super.refreshToken, required super.user});

  LoginResponseDtoModel copyWith({
    String? accessToken,
    String? refreshToken,
    UserModel? user,
  }) {
    return LoginResponseDtoModel(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user,
    };
  }

  factory LoginResponseDtoModel.fromJson(Map<String, dynamic> map) {
    return LoginResponseDtoModel(
      accessToken: map['accessToken']?.toString()??'',
      refreshToken: map['refreshToken']?.toString()??'',
      user: UserModel.fromJson(map['user']),
    );
  }
}