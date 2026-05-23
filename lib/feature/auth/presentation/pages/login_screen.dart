import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:swasthyamap/common/widgets/bottom_sheets/app_bottom_sheet.dart';
import 'package:swasthyamap/common/widgets/containers/app_container.dart';
import 'package:swasthyamap/common/widgets/loader/basic_loader.dart';
import 'package:swasthyamap/core/config/routes/route_name.dart';
import 'package:swasthyamap/core/emuns/api_status_emun.dart';
import 'package:swasthyamap/feature/auth/presentation/bloc/auth_bloc.dart';

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
  String _email = "";
  String _password = "";
  final _formKey = GlobalKey<FormState>();

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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextInputField(
                    isRequired: true,
                    hintText: 'Email',
                    type: TextInputType.emailAddress,
                    label: "Email",
                    onChange: (val) {
                      setState(() {
                        _email = val;
                      });
                    },
                  ),
                  SizedBox(height: 15),
                  AppTextInputField(
                    isRequired: true,
                    label: "Password",
                    hintText: 'Password',
                    onChange: (val) {
                      setState(() {
                        _password = val;
                      });
                    },
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

                  BlocListener<AuthBloc, AuthState>(
                    listenWhen: (previous,current)=>previous.loginData.status != current.loginData.status,
                    listener: (context, state) {
                      if(state.loginData.status == Status.LOADING){
                        BasicLoader.show(context);
                      }
                      if(state.loginData.status == Status.COMPLETED){
                        BasicLoader.hide(context);
                        context.goNamed(RouteName.homeScreen);
                      }
                      if(state.loginData.status == Status.ERROR){
                        BasicLoader.hide(context);
                      }
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: BasicAppButton(
                        buttonName: 'Login',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              AuthLogin(
                                userName: _email.trim(),
                                password: _password.trim(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () async {
                await AppBottomSheet.appBottomSheet(
                  context,
                  ForgotPasswordForm(),
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

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
