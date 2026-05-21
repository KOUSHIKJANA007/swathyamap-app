import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/theme/app_color.dart';
import '../text/app_text_widget.dart';

class AppTextInputField extends StatefulWidget {
  const AppTextInputField({
    this.focusColor = AppColor.primaryColor,
    this.label = "",
    this.borderRadius = 10.0,
    this.innerPadding,
    this.type = TextInputType.text,
    this.isRequired = false,
    this.onChange,
    this.value,
    this.maxLine = 1,
    this.readOnly=false,
    this.inputFormatters,
    super.key,
    this.hintText,
     this.isObscureText = false, this.prefixIcon, this.suffixIcon

  });
  final Color focusColor;
  final double borderRadius;
  final String label;
  final EdgeInsetsGeometry? innerPadding;
  final bool isRequired;
  final TextInputType type;
  final void Function(String)? onChange;
  final String? value;
  final String? hintText;
  final bool readOnly;
  final int maxLine;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isObscureText;

  @override
  State<AppTextInputField> createState() => _AppTextInputFieldState();
}

class _AppTextInputFieldState extends State<AppTextInputField> {
  final TextEditingController _controller=TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text=widget.value ?? '';
  }
  @override
  @override
  void didUpdateWidget(covariant AppTextInputField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != null &&
        widget.value != _controller.text) {

      final cursorPosition = _controller.selection;

      _controller.value = TextEditingValue(
        text: widget.value!,
        selection: cursorPosition.copyWith(
          baseOffset: cursorPosition.baseOffset.clamp(
            0,
            widget.value!.length,
          ),
          extentOffset: cursorPosition.extentOffset.clamp(
            0,
            widget.value!.length,
          ),
        ),
      );
    }
  }
  @override
  void dispose() {
    _controller.clear();
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(
            text:widget.isRequired ? "${widget.label} *" : widget.label,
            fontSize: 14,fontWeight: FontWeight.w400,
            color: AppColor.subTextColor.withAlpha(230)
        ),
        const SizedBox(height: 4),
        TextFormField(
          validator: (val){
            if(widget.isRequired && (val==null || val.isEmpty)){
              return "${widget.label} is required";
            }else{
              return null;
            }
          },
          inputFormatters: widget.inputFormatters,
          maxLines: widget.maxLine,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: widget.type,
          controller: _controller,
          readOnly: widget.readOnly,
          onChanged: widget.onChange,
          autocorrect: false,
          obscureText: widget.isObscureText,
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            enabled: !widget.readOnly,
            contentPadding: widget.innerPadding,
            hintText: widget.hintText,
            hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.sp,color: AppColor.subTextColor.withAlpha(204)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  width: 1.0,
                  color: AppColor.subTextColor.withAlpha(41),
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                    width: 1.0,
                    color: widget.focusColor)),
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
              borderSide: BorderSide(width: 1.0,  color: AppColor.subTextColor.withAlpha(25),),
            ),
          ),
        ),
      ],
    );
  }
}
