import 'package:flutter/material.dart';
import 'package:gitty/src/values/colors.dart';

class AppLightTheme {
  static AppLightTheme instance = AppLightTheme();

  ThemeData getLightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.instance.white,
    );
  }
}
