import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/core/theme/text_style.dart';
// import 'package:exodus/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.background,
      primaryContainer: AppColors.primary,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      titleTextStyle: AppText.h2,
      iconTheme: IconThemeData(color: AppColors.secondary),
    ),

    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: AppButtonStyles.primary,
    // ),
    // outlinedButtonTheme: OutlinedButtonThemeData(
    //   style: AppButtonStyles.primaryOutline,
    // ),
    inputDecorationTheme: InputDecorationTheme(iconColor: AppColors.inputIcon),

    textTheme: TextTheme(
      displayLarge: AppText.h1,
      displayMedium: AppText.h2,
      titleLarge: AppText.h3,
      bodyLarge: AppText.bodyMedium,
      bodyMedium: AppText.bodyRegular,
      bodySmall: AppText.smallRegular,
      labelSmall: AppText.tinyRegular,
    ),
    iconTheme: const IconThemeData(color: AppColors.icon),
  );
}
