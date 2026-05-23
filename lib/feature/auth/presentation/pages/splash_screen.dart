import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swasthyamap/common/widgets/containers/app_container.dart';
import 'package:swasthyamap/common/widgets/scaffold/app_scaffold.dart';
import 'package:swasthyamap/core/config/assets/app_images.dart';
import 'package:swasthyamap/core/config/routes/route_name.dart';
import 'package:swasthyamap/core/config/theme/app_color.dart';
import 'package:swasthyamap/core/services/auth_service/auth_session_service.dart';
import 'package:swasthyamap/feature/auth/domain/entities/user.dart';
import 'package:swasthyamap/injection_container.dart';

import '../../../../core/config/routes/app_routes.dart';
import '../bloc/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacity;
  late AuthSessionService authSessionService;


  @override
  void initState() {
    super.initState();
    authSessionService = sl<AuthSessionService>();
    context.read<AuthBloc>().add(AuthFindLoggedInUser());
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1, 0), // from left
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _opacity = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
    _init();
  }
  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 2));
    final user = await authSessionService.getCurrentUser();
    if (!mounted) return;
    if (user != null) {
       if (!mounted) return;
       _finalizeAndNavigate(user);
    } else {
      isSplashInitComplete = true;
      if (pendingDeepLinkPath != null && pendingDeepLinkPath!.isNotEmpty) {
        final target = pendingDeepLinkPath!;
        pendingDeepLinkPath = null; // Clear the memory cache

        context.go(target);
      } else {
        context.goNamed(RouteName.loginScreen);
      }
    }
  }

  void _finalizeAndNavigate(User user) {

    isSplashInitComplete = true;
      // 2. Check if a deep link path was captured during cold boot
      if (pendingDeepLinkPath != null && pendingDeepLinkPath!.isNotEmpty) {
        final target = pendingDeepLinkPath!;
        pendingDeepLinkPath = null;
        context.go(target);
      } else {
        context.goNamed(RouteName.homeScreen, extra: user);
      }

  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body:  Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: _opacity,
              child: Image.asset(AppImages.appLogo,width: 150,height: 150),
            ),
            FadeTransition(
              opacity: _opacity,
              child: SlideTransition(
                  position: _offsetAnimation,
                  child: Image.asset(AppImages.appName,width: 200)
              ),
            )
          ],
        ),
      ),
    );
  }
}
