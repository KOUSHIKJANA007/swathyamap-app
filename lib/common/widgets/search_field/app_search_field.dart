import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/theme/app_color.dart';

class AppSearchField extends StatefulWidget {
  const AppSearchField({
    this.borderRadius = 10.0,
    this.innerPadding = const EdgeInsets.symmetric(vertical: 17,horizontal: 16),
    this.onChange,
    this.value,
    this.maxLine = 1,
    this.readOnly=false,
    super.key,
    this.hintText, this.prefixIcon,
    this.isObscureText = false, this.suffixIcon, this.validator, this.controller, this.onTap
  });
  final double borderRadius;
  final EdgeInsetsGeometry? innerPadding;
  final void Function(String)? onChange;
  final String? value;
  final String? hintText;
  final bool readOnly;
  final int maxLine;
  final Widget? prefixIcon;
  final bool isObscureText;
  final Widget? suffixIcon;
  final FormFieldValidator<String?>? validator;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChange,
      onTap: widget.onTap,
      decoration: InputDecoration(
        enabled: !widget.readOnly,
        contentPadding: widget.innerPadding,
        hintText: widget.hintText,
        suffixIcon: widget.suffixIcon,
        filled: true,
        fillColor: AppColor.lightBgColor,
        isDense: true,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 12, right: 5),
          child: widget.prefixIcon,
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),
        hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 16.sp,color: AppColor.subTextColor),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              width: 1.0,
              color: AppColor.darkBgColor.withAlpha(35),
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
                width: 1.0,
              color: AppColor.darkBgColor.withAlpha(35))),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: const BorderSide(
                color: Color(0xFFCA0E05), width: 1.0)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: const BorderSide(
                color: Color(0xFFCA0E05), width: 1.0)),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
