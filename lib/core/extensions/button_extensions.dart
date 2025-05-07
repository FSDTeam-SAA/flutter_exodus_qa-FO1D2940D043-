import 'package:exodus/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

extension ButtonStyleExtensions on BuildContext {
  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.white,
    minimumSize: const Size.fromHeight(43),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
    ),
  );

  ButtonStyle get secondaryButton => ElevatedButton.styleFrom(
    backgroundColor: AppColors.backgroundLight,
    foregroundColor: AppColors.primary,
    minimumSize: const Size(130, 43),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
    ),
  );

  ButtonStyle get primaryOutline => OutlinedButton.styleFrom(
    side: const BorderSide(color: AppColors.primary),
    foregroundColor: AppColors.primary,
    minimumSize: const Size.fromHeight(43),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
    ),
  );

  ButtonStyle get errorOutline => OutlinedButton.styleFrom(
    side: const BorderSide(color: AppColors.error),
    foregroundColor: AppColors.error,
    minimumSize: const Size.fromHeight(43),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
    ),
  );
}
