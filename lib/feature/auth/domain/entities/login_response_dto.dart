import 'package:equatable/equatable.dart';
import 'package:swasthyamap/feature/auth/domain/entities/user.dart';

class LoginResponseDto extends Equatable{
  final String accessToken;
  final String refreshToken;
  final User user;

  const LoginResponseDto({required this.accessToken, required this.refreshToken, required this.user});

  @override
  List<Object?> get props => [accessToken,refreshToken,user];
}