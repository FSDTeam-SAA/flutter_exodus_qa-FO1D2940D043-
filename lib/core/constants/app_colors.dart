import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFD4ECFD);
  static const Color primary = Color(0xFF0F7AC0);
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF787878);
  static const Color icon = Color(0xFF595959);
  static const Color white = Color(0xFFFFFFFF);
  static const Color warningBackground = Color(0xFFFAEBEB);
  static const Color error = Color(0xFFCE3837);
  static const Color success = Color(0xFF09B850);
  static const Color backgroundLight = Color(0xFFDBEBF6);

  // Button styles (for convenience)
  static const Color buttonBackground = primary;
  static const Color buttonText = white; // when background is primary

  // Add these new form field specific colors
  static const Color inputBorder = Color(0xFFB0C7D9); // Light blue-gray border
  static const Color inputFocusedBorder = primary; // Use your primary blue
  static const Color inputErrorBorder = error; // Use your existing error red
  static const Color inputFill = white; // White background
  static const Color inputHint = textSecondary; // Use your textSecondary
  static const Color inputLabel = textPrimary; // Use your textPrimary
  static const Color inputDisabledFill = Color(0xFFF5F5F5,); // Light gray for disabled
}
