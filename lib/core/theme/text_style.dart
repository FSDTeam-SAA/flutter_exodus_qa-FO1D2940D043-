import 'package:exodus/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppText {
  AppText._(); // Private constructor to prevent instantiation

  static const String _fontFamily = 'Poppins';

  static TextStyle _style({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.textPrimary,
    );
  }

  // Header styles
  static final TextStyle h1 = _style(fontSize: 24, fontWeight: FontWeight.w600);
  static final TextStyle h2 = _style(fontSize: 20, fontWeight: FontWeight.w600);
  static final TextStyle h3 = _style(fontSize: 18, fontWeight: FontWeight.w500);

  // Body styles
  static final TextStyle bodySemiBold = _style(fontSize: 16, fontWeight: FontWeight.w600);
  static final TextStyle bodyMedium = _style(fontSize: 16, fontWeight: FontWeight.w500);
  static final TextStyle bodyRegular = _style(fontSize: 16, fontWeight: FontWeight.w400);
  static final TextStyle bodyExtraLarg = _style(fontSize: 24, fontWeight: FontWeight.w600);

  // Small styles
  static final TextStyle smallMedium = _style(fontSize: 14, fontWeight: FontWeight.w500);
  static final TextStyle smallRegular = _style(fontSize: 14, fontWeight: FontWeight.w400);

  // Tiny styles
  static final TextStyle tinyMedium = _style(fontSize: 12, fontWeight: FontWeight.w500);
  static final TextStyle tinyRegular = _style(fontSize: 12, fontWeight: FontWeight.w400);
}