import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/theme/app_color.dart';
import '../text/app_text_widget.dart';

class AppRadioButton<T> extends StatelessWidget {
  const AppRadioButton({
    super.key,
    required this.value,
    required this.isSelected,
    this.label,
    required this.onTap, this.isDisable = false,
  });

  final T value;
  final bool isSelected;
  final String? label;
  final void Function(T?)? onTap;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:()=> isDisable ? (){}:onTap?.call(value),
      child: Row(
        spacing: 12,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: 20.w,
            width: 20.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: (isSelected && !isDisable)
                    ? AppColor.primaryColor
                    : isDisable ? AppColor.lightBgColor.withAlpha(100) : AppColor.subTextColor,
                width: 2,
              ),
            ),
            child:  (isSelected && !isDisable)
                ? Center(
              child: Container(
                height: 10.w,
                width: 10.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primaryColor,
                ),
              ),
            )
                : null,
          ),
          if(label != null)
            Flexible(
              child: AppTextWidget(
                text: label??'',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: isDisable ? AppColor.subTextColor.withAlpha(100) : AppColor.subTextColor,
              ),
            ),
        ],
      ),
    );
  }
}
