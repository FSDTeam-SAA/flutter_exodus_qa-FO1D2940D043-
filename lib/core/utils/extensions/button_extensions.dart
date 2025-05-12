import 'package:exodus/core/constants/app_colors.dart';
import 'package:exodus/core/constants/app_sizes.dart';
import 'package:exodus/core/theme/text_style.dart';
import 'package:exodus/presentation/widgets/gradient_primary_button.dart';
import 'package:exodus/presentation/widgets/gradient_secondary_button.dart';
import 'package:flutter/material.dart';

extension ButtonStyleExtensions on BuildContext {
  Widget primaryButton({
    required VoidCallback onPressed,
    required String text,
    double? width,
  }) {
    return GradientButtonPrimary(
      onPressed: onPressed,
      isPrimary: true,
      gradient: AppColors.primaryGradient,
      child: Text(
        text,
        style: AppText.bodyMedium.copyWith(color: AppColors.background),
      ),
      // const LinearGradient(
      //   colors: [
      //     AppColors.primary,
      //     AppColors.primaryLight,
      //     AppColors.primaryDark,
      //   ],
      //   begin: Alignment.topLeft,
      //   end: Alignment.bottomRight,
      // ),
    );
  }

  Widget secondaryButton({
    required VoidCallback onPressed,
    required String text,
    double? width,
  }) {
    return GradientButtonSecondary(
      onPressed: onPressed,
      isPrimary: true,
      gradient: AppColors.primaryGradient,
      child: Text(
        text,
        // style: AppText.bodyMed ium.copyWith(color: AppColors.background),
      ),
      // const LinearGradient(
      //   colors: [
      //     AppColors.primary,
      //     AppColors.primaryLight,
      //     AppColors.primaryDark,
      //   ],
      //   begin: Alignment.topLeft,
      //   end: Alignment.bottomRight,
      // ),
    );
  }
  // ButtonStyle get primaryButton => ElevatedButton.styleFrom(
  //   backgroundColor: AppColors.primary,
  //   foregroundColor: AppColors.background,
  //   minimumSize: const Size.fromHeight(AppSizes.buttonHeightLarge),
  //   shape: RoundedRectangleBorder(borderRadius: AppSizes.borderRadiusMedium),
  //   textStyle: AppText.bodyMedium,
  // );

  // ButtonStyle get secondaryButton => ElevatedButton.styleFrom(
  //   backgroundColor: AppColors.backgroundLight,
  //   foregroundColor: AppColors.primary,
  //   minimumSize: const Size(130, AppSizes.buttonHeightLarge),
  //   shape: RoundedRectangleBorder(borderRadius: AppSizes.borderRadiusMedium),
  //   textStyle: AppText.bodyMedium,
  // );

  ButtonStyle get primaryOutline => OutlinedButton.styleFrom(
    side: const BorderSide(color: AppColors.primary),
    foregroundColor: AppColors.primary,
    minimumSize: const Size.fromHeight(AppSizes.buttonHeightLarge),
    shape: RoundedRectangleBorder(borderRadius: AppSizes.borderRadiusMedium),
    textStyle: AppText.smallMedium,
  );

  // ButtonStyle get errorOutline => OutlinedButton.styleFrom(
  //   side: const BorderSide(color: AppColors.error),
  //   foregroundColor: AppColors.error,
  //   minimumSize: const Size.fromHeight(AppSizes.buttonHeightLarge),
  //   shape: RoundedRectangleBorder(borderRadius: AppSizes.borderRadiusMedium),
  //   textStyle: AppText.smallMedium,
  // );
}
