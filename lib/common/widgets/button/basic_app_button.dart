import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swasthyamap/core/config/theme/app_color.dart';

import '../text/app_text_widget.dart';

class BasicAppButton extends StatelessWidget {
  const BasicAppButton({super.key, required this.buttonName, required this.onTap,
    this.padding = const EdgeInsets.symmetric(vertical: 15),
    this.borderRadius = 12.0,
    this.btnNameSize = 18.0
  });

  final String buttonName;
  final VoidCallback onTap;
  final EdgeInsets padding;
  final double borderRadius;
  final double btnNameSize;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)
          ),
          padding: padding
        ),
        onPressed: onTap,
        child: AppTextWidget(text: buttonName,fontWeight: FontWeight.w500,fontSize: btnNameSize,color: AppColor.lightBgColor)
    );
  }
}