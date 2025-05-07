import 'package:exodus/core/constants/app_colors.dart';
import 'package:exodus/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: AppButtonStyles.primary,
    // ),
    // outlinedButtonTheme: OutlinedButtonThemeData(
    //   style: AppButtonStyles.primaryOutline,
    // ),
    textTheme: TextTheme(
      displayLarge: AppTextBase.h1,
      displayMedium: AppTextBase.h2,
      titleLarge: AppTextBase.h3,
      bodyLarge: AppTextBase.bodyMedium,
      bodyMedium: AppTextBase.bodyRegular,
      bodySmall: AppTextBase.smallRegular,
      labelSmall: AppTextBase.tinyRegular,
    ),
    iconTheme: const IconThemeData(color: AppColors.icon),
  );
}
