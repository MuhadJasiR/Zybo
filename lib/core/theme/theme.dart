import 'package:flutter/material.dart';
import 'package:zybo/core/theme/app_color.dart';

class AppTheme {
  static final theme = ThemeData(
      scaffoldBackgroundColor: AppColor.whiteColor,
      appBarTheme: const AppBarTheme(backgroundColor: AppColor.whiteColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        fixedSize: const WidgetStatePropertyAll(Size(350, 51)),
        foregroundColor: const WidgetStatePropertyAll(AppColor.whiteColor),
        backgroundColor: const WidgetStatePropertyAll(AppColor.primaryColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      )));
}
