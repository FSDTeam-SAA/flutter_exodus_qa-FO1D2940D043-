// core/theme/app_styles.dart
import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/core/constants/app/app_sizes.dart';
import 'package:flutter/material.dart';

class AppDecorations {
  static final card = BoxDecoration(
    color: AppColors.background,
    borderRadius: AppSizes.borderRadiusMedium,
    boxShadow: [
      BoxShadow(
        color: AppColors.secondary.withValues(alpha: 0.1),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
  );
}
