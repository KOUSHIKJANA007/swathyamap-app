import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swasthyamap/core/config/routes/route_name.dart';
import 'package:swasthyamap/feature/auth/presentation/pages/login_screen.dart';
import 'package:swasthyamap/feature/auth/presentation/pages/otp_verify_screen.dart';
import 'package:swasthyamap/feature/auth/presentation/pages/sign_up_screen.dart';
import 'package:swasthyamap/feature/auth/presentation/pages/splash_screen.dart';
import '../../services/auth_service/auth_session_service.dart';

class AppRoutes {
  late final GoRouter router;
  final AuthSessionService authSessionService;

  AppRoutes({required this.authSessionService}) {
    router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            name: RouteName.splashScreen,
            path: '/',
            pageBuilder: (context, state) {
              return MaterialPage(
                  child: SplashScreen()
              );
            },
          ),
          GoRoute(
            name: RouteName.loginScreen,
            path: '/${RouteName.loginScreen}',
            pageBuilder: (context, state) {
              return MaterialPage(
                  child: LoginScreen()
              );
            },
          ),
          GoRoute(
            name: RouteName.signUpScreen,
            path: '/${RouteName.signUpScreen}',
            pageBuilder: (context, state) {
              return MaterialPage(
                  child: SignUpScreen()
              );
            },
          ),
          GoRoute(
            name: RouteName.otpVerifyScreen,
            path: '/${RouteName.otpVerifyScreen}',
            pageBuilder: (context, state) {
              return MaterialPage(
                  child: OtpVerifyScreen()
              );
            },
          )
        ]
    );
  }
}