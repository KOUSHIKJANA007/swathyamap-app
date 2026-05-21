import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:swasthyamap/common/widgets/bottom_sheets/app_bottom_sheet.dart';
import 'package:swasthyamap/common/widgets/containers/app_container.dart';
import 'package:swasthyamap/core/config/routes/route_name.dart';

import '../../../../common/widgets/button/basic_app_button.dart';
import '../../../../common/widgets/checkboxes/app_checkbox.dart';
import '../../../../common/widgets/scaffold/app_scaffold.dart';
import '../../../../common/widgets/text/app_text_widget.dart';
import '../../../../common/widgets/text_input_fields/app_text_input_field.dart';
import '../../../../core/config/theme/app_color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscureText = false;
  bool isAgree = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 80),
            AppTextWidget(
              text: "Welcome Back",
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
            AppTextWidget(
              text:
                  "Login to access nearby doctors, hospitals, and emergency medical services.",
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.subTextColor,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 120.h),
            AppTextInputField(hintText: 'Email'),
            AppTextInputField(
              hintText: 'Password',
              isObscureText: isObscureText,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isObscureText = !isObscureText;
                  });
                },
                child: Icon(
                  isObscureText ? Icons.visibility : Icons.visibility_off,
                  size: 22,
                  color: AppColor.subTextColor,
                ),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: BasicAppButton(buttonName: 'Login', onTap: () {
                context.goNamed(RouteName.homeScreen);
              }),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () async{
                await AppBottomSheet.appBottomSheet(
                    context,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        text: "Welcome Back",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      AppTextWidget(
                        text:
                        "Enter your email for the verification process,we will send 4 digits code to your email.",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.subTextColor,
                      ),
                      const SizedBox(height: 20),
                      AppTextInputField(hintText: 'Email'),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: BasicAppButton(buttonName: 'Continue', onTap: () {}),
                      ),
                      const SizedBox(height: 20),
                    ],
                  )
                );
              },
              child: AppTextWidget(
                text: "Forgot Password",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.primaryColor,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: SafeArea(
        child: GestureDetector(
          onTap: () {
            GoRouter.of(context).pushNamed(RouteName.signUpScreen);
          },
          child: AppTextWidget(
            text: "Don’t have an account? Join us",
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.primaryColor,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
