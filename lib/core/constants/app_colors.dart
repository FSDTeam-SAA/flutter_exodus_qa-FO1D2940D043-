import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF1F2022);

  static const Color primary = Color(0xFFF3E898);
  static const Color primaryDark = Color(0xFF946329);

  static const Color secondary = Color(0xFFC0A05C);
  static const Color textPrimary = secondary;
  static const Color textSecondary = textPrimary;

  static const Color icon = Color(0xFF595959);
  static const Color white = Color(0xFFFFFFFF);
  static const Color warningBackground = Color(0xFFFAEBEB);
  static const Color error = Color(0xFFCE3837);
  static const Color success = Color(0xFF09B850);
  static const Color backgroundLight = Color(0xFFDBEBF6);

  // Button styles (for convenience)
  static const Color buttonBackground = primary;
  static const Color buttonText = background; // when background is primary

  // Add these new form field specific colors
  static const Color inputBorder = primaryDark; // Light blue-gray border
  static const Color inputFocusedBorder = primaryDark; // Use your primary blue
  static const Color inputErrorBorder = error; // Use your existing error red
  static const Color inputFill = white; // White background
  static const Color inputHint = textSecondary; // Use your textSecondary
  static const Color inputLabel = textPrimary; // Use your textPrimary
  static const Color inputIcon = Color(0xFF70603F);
  
  static const Color inputDisabledFill = Color(
    0xFFF5F5F5,
  ); // Light gray for disabled

  static const Gradient primaryGradient = LinearGradient(
    colors: [primaryDark, primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.2, 0.5, 7.0],
    transform: GradientRotation(45 * (pi / 180)),
  );
}
