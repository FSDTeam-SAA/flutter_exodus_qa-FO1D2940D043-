import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:flutter/material.dart';

class AppButtonStyles {
  static final ButtonStyle primary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.white,
    minimumSize: const Size.fromHeight(43),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      fontFamily: 'Poppins',
    ),
  );

  static final ButtonStyle secondary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.backgroundLight,
    foregroundColor: AppColors.primary,
    minimumSize: const Size(130, 43),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      fontFamily: 'Poppins',
    ),
  );

  static final ButtonStyle primaryOutline = OutlinedButton.styleFrom(
    side: const BorderSide(color: AppColors.primary),
    foregroundColor: AppColors.primary,
    minimumSize: const Size.fromHeight(43),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      fontFamily: 'Poppins',
    ),
  );

  static final ButtonStyle errorOutline = OutlinedButton.styleFrom(
    side: const BorderSide(color: AppColors.error),
    foregroundColor: AppColors.error,
    minimumSize: const Size.fromHeight(43),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      fontFamily: 'Poppins',
    ),
  );
}
