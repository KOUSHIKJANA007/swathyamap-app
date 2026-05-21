import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swasthyamap/core/config/theme/app_color.dart';

import '../text/app_text_widget.dart';

class BasicAppButton extends StatelessWidget {
  const BasicAppButton({super.key, required this.buttonName, required this.onTap});

  final String buttonName;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
          ),
          padding: EdgeInsets.symmetric(vertical: 15)
        ),
        onPressed: onTap,
        child: AppTextWidget(text: buttonName,fontWeight: FontWeight.w500,fontSize: 18.sp,color: AppColor.lightBgColor)
    );
  }
}