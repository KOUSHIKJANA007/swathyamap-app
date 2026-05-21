import 'package:flutter/material.dart';
import '../../../core/config/theme/app_color.dart';

class AppTextWidget extends StatelessWidget {
  const AppTextWidget({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.bold,
    this.maxLine,
    this.textOverflow,
    this.fontSize = 18,
    this.color = AppColor.darkBgColor, this.textAlign, this.decorationColor, this.decoration, this.height,
    this.fontFamily = 'rubik'
  });

  final String text;
  final String fontFamily;
  final FontWeight fontWeight;
  final int? maxLine;
  final TextOverflow? textOverflow;
  final double fontSize;
  final Color color;
  final TextAlign? textAlign;
  final Color? decorationColor;
  final TextDecoration? decoration;
  final double? height;


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      overflow: textOverflow,
      style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
          decorationColor: decorationColor,
          decoration: decoration,
          height: height,
        fontFamily: fontFamily
      ),
      textAlign: textAlign,
    );
  }
}
