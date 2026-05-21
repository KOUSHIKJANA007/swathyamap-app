import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/config/theme/app_color.dart';

class AppScaffold extends StatelessWidget {

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation?
  floatingActionButtonLocation;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool showBlur;
  final Widget? persistentFooterButtons;
  final AlignmentGeometry blurAlignment;

  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.showBlur = true,
    this.persistentFooterButtons,
    this.blurAlignment = Alignment.bottomRight,
  });


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation:
      floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      backgroundColor:
      backgroundColor ?? const Color(0xffF5F5F5),
      resizeToAvoidBottomInset:
      resizeToAvoidBottomInset,
      extendBody: extendBody,
      extendBodyBehindAppBar:
      extendBodyBehindAppBar,

      body: Stack(
        children: [
          /// Bottom Right Blur
          Positioned(
            bottom: -80,
            right: -80,
            child: Container(
              width: width * 0.6,
              height: height * 0.3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primaryColor.withOpacity(0.35),
              ),
            ),
          ),

          Positioned(
            top: -80,
            left: -80,
            child: Container(
              width: width * 0.7,
              height: height * 0.4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.secondaryColor.withOpacity(0.35),
              ),
            ),
          ),

          /// Blur Effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 80,
                sigmaY: 80,
              ),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),

          /// Content
          SizedBox.expand(
            child: SafeArea(
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}
