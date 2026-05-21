import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swasthyamap/common/widgets/containers/app_container.dart';
import 'package:swasthyamap/common/widgets/scaffold/app_scaffold.dart';
import 'package:swasthyamap/core/config/assets/app_images.dart';
import 'package:swasthyamap/core/config/routes/route_name.dart';
import 'package:swasthyamap/core/config/theme/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacity;


  @override
  void initState() {
    super.initState();
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

    Future.delayed(Duration(seconds: 2),(){
      context.goNamed(RouteName.signUpScreen);
    });
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
