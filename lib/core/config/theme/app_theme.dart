import 'package:flutter/material.dart';
import 'package:swasthyamap/core/config/theme/app_color.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColor.primaryColor,
    scaffoldBackgroundColor: AppColor.lightBgColor,
    brightness: Brightness.light,
    fontFamily: 'rubik',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
       backgroundColor: AppColor.primaryColor,
        textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        )
      )
    )
  );

  static final darkTheme = ThemeData(
      primaryColor: AppColor.primaryColor,
      scaffoldBackgroundColor: AppColor.darkBgColor,
      brightness: Brightness.dark,
      fontFamily: 'rubik',
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
              textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              )
          )
      )
  );
}