import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/theme/app_color.dart';
import '../text/app_text_widget.dart';

class AppCheckbox extends StatefulWidget {

  const AppCheckbox({
    super.key,
    this.activeColor = AppColor.primaryColor,
    this.value,
    required this.title,
    this.onChange,
    this.isRequired = false,
    this.titleColor = AppColor.subTextColor, 
    this.borderRadius = 3.0,
  });

  final Color activeColor;
  final bool? value;
  final String title;
  final void Function(bool?)? onChange;
  final bool isRequired;
  final Color titleColor;
  final double borderRadius;

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      initialValue: widget.value,
      validator: (value) {
        if (widget.isRequired && (value == null || !value)) {
          return "Please check the box";
        }
        return null;
      },
      builder: (state) {
        final isError = state.hasError;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: widget.activeColor,
                    value: widget.value ?? false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.borderRadius)
                    ),
                    onChanged: (val) {
                      state.didChange(val);
                      widget.onChange?.call(val);
                    },
                  ),
                ),
                Expanded(
                  child: AppTextWidget(
                    text: widget.isRequired
                        ? "${widget.title} *"
                        : widget.title,
                    fontSize: 12.sp,
                    color: widget.titleColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            if (isError)
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 0.0),
                child: AppTextWidget(
                  text: "Please check the box",
                  color: Colors.red,
                  fontSize: 12,
                ),
              )
            else
              SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
