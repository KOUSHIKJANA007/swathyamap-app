import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:swasthyamap/core/config/theme/app_color.dart';

class AppOtpInputField extends StatelessWidget {
  final int length;
  final Function(String)? onCompleted;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool obscureText;
  final FocusNode? focusNode;

  const AppOtpInputField({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
    this.controller,
    this.obscureText = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: 56.w,
      height: 60.h,

      textStyle: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),

        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
    );

    return Pinput(
      controller: controller,
      focusNode: focusNode,
      length: length,
      obscureText: obscureText,

      defaultPinTheme: defaultTheme,

      focusedPinTheme: defaultTheme.copyWith(
        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(16.r),

          border: Border.all(
            color: const Color(0xff18C79C),
            width: 2,
          ),
        ),
      ),

      submittedPinTheme: defaultTheme.copyWith(
        decoration: BoxDecoration(
          color: const Color(0xffF4FFFB),

          borderRadius: BorderRadius.circular(16.r),

          border: Border.all(
            color: AppColor.primaryColor,
          ),
        ),
      ),

      errorPinTheme: defaultTheme.copyBorderWith(
        border: Border.all(
          color: Colors.red,
        ),
      ),

      onCompleted: onCompleted,
      onChanged: onChanged,

      keyboardType: TextInputType.number,

      pinputAutovalidateMode:
      PinputAutovalidateMode.onSubmit,

      showCursor: true,

      cursor: Container(
        width: 2.w,
        height: 24.h,
        color: AppColor.primaryColor,
      ),
    );
  }
}