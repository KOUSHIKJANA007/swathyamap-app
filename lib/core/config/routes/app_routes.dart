import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swasthyamap/core/config/routes/route_name.dart';
import 'package:swasthyamap/feature/app_menu/presentation/pages/app_menu_screen.dart';
import 'package:swasthyamap/feature/auth/presentation/pages/login_screen.dart';
import 'package:swasthyamap/feature/auth/presentation/pages/otp_verify_screen.dart';
import 'package:swasthyamap/feature/auth/presentation/pages/sign_up_screen.dart';
import 'package:swasthyamap/feature/auth/presentation/pages/splash_screen.dart';
import 'package:swasthyamap/feature/dashboard/presentation/pages/home.dart';
import 'package:swasthyamap/feature/search_services/presentation/pages/search_filter.dart';
import 'package:swasthyamap/feature/search_services/presentation/pages/search_screen.dart';
import 'package:swasthyamap/feature/doctor/presentation/pages/doctor_appointment.dart';
import 'package:swasthyamap/feature/institution/presentation/pages/institutions_screen.dart';
import 'package:swasthyamap/navigation_bar_layout.dart';
import '../../../feature/search_services/presentation/bloc/search_bloc.dart';
import '../../../injection_container.dart';
import '../../services/auth_service/auth_session_service.dart';

bool isSplashInitComplete = false;
String? pendingDeepLinkPath;


class AppRoutes {
  late final GoRouter router;
  final AuthSessionService authSessionService;

  AppRoutes({required this.authSessionService}) {
    router = GoRouter(
        redirect: (context, state) async {
          if (!isSplashInitComplete) {
            final currentPath = state.uri.path;

            if (currentPath != '/') {
              pendingDeepLinkPath = state.uri.toString();
            }
            return '/';
          }
          return null;
        },
        initialLocation: '/',
        routes: [
          ShellRoute(
            builder: (context, state, child) {
              return NavigationBarLayout(child: child);
            },

            routes: [
              GoRoute(
                name: RouteName.homeScreen,
                path: '/${RouteName.homeScreen}',
                pageBuilder: (context, state) {
                  return MaterialPage(
                      child: Home()
                  );
                },
              ),
              GoRoute(
                name: RouteName.institutionScreen,
                path: '/${RouteName.institutionScreen}',
                pageBuilder: (context, state) {
                  return MaterialPage(
                      child: InstitutionsScreen()
                  );
                },
              ),

              GoRoute(
                name: RouteName.searchScreen,
                path: '/${RouteName.searchScreen}',
                pageBuilder: (context, state) {
                  return MaterialPage(
                      child: BlocProvider(
                        create: (context) => sl<SearchBloc>(),
                        child: SearchScreen(),
                      )
                  );
                },
              ),
              GoRoute(
                name: RouteName.appointmentScreen,
                path: '/${RouteName.appointmentScreen}',
                pageBuilder: (context, state) {
                  return MaterialPage(
                      child: DoctorAppointment()
                  );
                },
              ),
              GoRoute(
                name: RouteName.appMenuScreen,
                path: '/${RouteName.appMenuScreen}',
                pageBuilder: (context, state) {
                  return MaterialPage(
                      child: AppMenuScreen()
                  );
                },
              ),
            ],
          ),
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
          ),
          GoRoute(
            name: RouteName.searchFilterScreen,
            path: '/${RouteName.searchFilterScreen}',
            pageBuilder: (context, state) {
              return MaterialPage(
                  child: SearchFilter()
              );
            },
          )
        ]
    );
  }
}