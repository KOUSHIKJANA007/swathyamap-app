
import 'package:flutter/material.dart';
import 'package:swasthyamap/core/config/theme/app_color.dart';

// class AppTextWidget {
//   static Widget AppText({
//     required String text,
//     FontWeight fontWeight = FontWeight.bold,
//     double fontSize = 18,
//     Color color = AppColor.headingTextColor,
//     int? maxLine,
//     TextOverflow? textOverflow
//   }){
//     return Text(
//         text,
//       maxLines: maxLine,
//       overflow: textOverflow,
//       style: TextStyle(
//         fontWeight: fontWeight,
//         fontSize: fontSize,
//         color: color
//       ),
//     );
//   }
// }

class AppTextWidget extends StatelessWidget {
  const AppTextWidget({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.bold,
    this.maxLine,
    this.textOverflow,
    this.fontSize = 18,
    this.color = AppColor.headingTextColor
  });

  final String text;
  final FontWeight fontWeight;
  final int? maxLine;
  final TextOverflow? textOverflow;
  final double fontSize;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Text(
        text,
      maxLines: maxLine,
      overflow: textOverflow,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color
      ),
    );
  }
}
