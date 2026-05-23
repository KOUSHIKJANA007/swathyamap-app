import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/config/theme/app_color.dart';

class BasicLoader {
  BasicLoader._();
  static void show(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.all(160),
            backgroundColor: Colors.transparent,
            child: PopScope(
                canPop: false,
                child: Center(
                  child: SizedBox(
                      height: 60,
                      width: 60,
                      child: CircularProgressIndicator(color: AppColor.primaryColor)),
                )
            ),
          );
        });
  }

  static void hide(BuildContext context) {
    if (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }
  }
}
