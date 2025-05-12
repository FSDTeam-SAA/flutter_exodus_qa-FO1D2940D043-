import 'package:exodus/core/constants/app_colors.dart';
import 'package:exodus/core/constants/app_padding.dart';
import 'package:exodus/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

extension InputDecorationExtensions on BuildContext {
  InputDecoration get primaryInputDecoration => InputDecoration(
    filled: true,
    suffixIconColor: AppColors.inputIcon,
    fillColor: AppColors.background,
    contentPadding: AppPaddings.all16,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSmall),
      borderSide: const BorderSide(color: AppColors.inputBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSmall),
      borderSide: const BorderSide(color: AppColors.inputBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSmall),
      borderSide: const BorderSide(
        color: AppColors.inputFocusedBorder,
        width: 1.5,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSmall),
      borderSide: const BorderSide(
        color: AppColors.inputErrorBorder,
        width: 1.5,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSmall),
      borderSide: const BorderSide(
        color: AppColors.inputErrorBorder,
        width: 1.5,
      ),
    ),
    hintStyle: TextStyle(
      color: AppColors.inputHint,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    labelStyle: TextStyle(
      color: AppColors.inputLabel,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    errorStyle: TextStyle(
      color: AppColors.error,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );
}
