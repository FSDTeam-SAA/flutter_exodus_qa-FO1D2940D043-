import 'package:flutter/material.dart';

class AppTextBase {
  static const String _fontFamily = 'Poppins';

  static const TextStyle base = TextStyle(fontFamily: _fontFamily);

  static TextStyle get h1 => base.copyWith(fontSize: 24, fontWeight: FontWeight.w600);
  static TextStyle get h2 => base.copyWith(fontSize: 20, fontWeight: FontWeight.w600);
  static TextStyle get h3 => base.copyWith(fontSize: 18, fontWeight: FontWeight.w500);

  static TextStyle get bodySemiBold => base.copyWith(fontSize: 16, fontWeight: FontWeight.w600);
  static TextStyle get bodyMedium => base.copyWith(fontSize: 16, fontWeight: FontWeight.w500);
  static TextStyle get bodyRegular => base.copyWith(fontSize: 16, fontWeight: FontWeight.w400);

  static TextStyle get smallMedium => base.copyWith(fontSize: 14, fontWeight: FontWeight.w500);
  static TextStyle get smallRegular => base.copyWith(fontSize: 14, fontWeight: FontWeight.w400);

  static TextStyle get tinyMedium => base.copyWith(fontSize: 12, fontWeight: FontWeight.w500);
  static TextStyle get tinyRegular => base.copyWith(fontSize: 12, fontWeight: FontWeight.w400);
}