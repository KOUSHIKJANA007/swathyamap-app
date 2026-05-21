import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:swasthyamap/common/widgets/button/basic_app_button.dart';
import 'package:swasthyamap/common/widgets/checkboxes/app_checkbox.dart';
import 'package:swasthyamap/common/widgets/scaffold/app_scaffold.dart';
import 'package:swasthyamap/common/widgets/text/app_text_widget.dart';
import 'package:swasthyamap/common/widgets/text_input_fields/app_text_input_field.dart';
import 'package:swasthyamap/core/config/routes/route_name.dart';
import 'package:swasthyamap/core/config/theme/app_color.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                  text: "Welcome to SwasthyaMap",
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
            AppTextWidget(
              text: "Find nearby doctors instantly.",
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.subTextColor,
              textAlign: TextAlign.center,
            ),
             SizedBox(height: 120.h),
            Row(
              children: [
                Expanded(
                  child: AppTextInputField(
                    hintText: 'First Name',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppTextInputField(
                    hintText: 'Last Name',
                  ),
                )
              ],
            ),
            AppTextInputField(
              hintText: 'Email',
            ),
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
                  isObscureText
                      ? Icons.visibility
                      : Icons.visibility_off,
                  size: 22,
                  color: AppColor.subTextColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            AppCheckbox(
                title: 'I agree with the Terms of Service & Privacy Policy',
              borderRadius: 5,
              value: isAgree,
              onChange: (val)=>setState(()=>isAgree = val??false),
            ),
            const SizedBox(height: 40),

            SizedBox(
                width: double.infinity,
                child: BasicAppButton(buttonName: 'Sign Up', onTap: (){
                  GoRouter.of(context).pushNamed(RouteName.otpVerifyScreen);
                })),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: ()=>GoRouter.of(context).pushNamed(RouteName.loginScreen),
              child: AppTextWidget(
                text: "Have an account? Log in",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.primaryColor,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
