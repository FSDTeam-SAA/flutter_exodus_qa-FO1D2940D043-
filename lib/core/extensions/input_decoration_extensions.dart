import 'package:exodus/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

extension InputDecorationExtensions on BuildContext {
  InputDecoration get standardInputDecoration => InputDecoration(
    filled: true,
    fillColor: AppColors.inputFill,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.inputBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.inputBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.inputFocusedBorder,
        width: 1.5,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.inputErrorBorder,
        width: 1.5,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
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

  // InputDecoration get searchInputDecoration => standardInputDecoration.copyWith(
  //   contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  //   prefixIcon: const Icon(Icons.search, color: AppColors.icon),
  //   hintText: 'Search...',
  //   border: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(24),
  //     borderSide: const BorderSide(color: AppColors.inputBorder),
  //   ),
  //   enabledBorder: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(24),
  //     borderSide: const BorderSide(color: AppColors.inputBorder),
  //   ),
  //   focusedBorder: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(24),
  //     borderSide: const BorderSide(
  //       color: AppColors.inputFocusedBorder,
  //       width: 1.5,
  //     ),
  //   ),
  // );
}
