import 'package:exodus/core/constants/app_colors.dart';
import 'package:exodus/core/constants/app_sizes.dart';
import 'package:exodus/core/theme/text_style.dart';
import 'package:flutter/material.dart';

extension CodeInputDecorationExtensions on BuildContext {
  InputDecoration get codeInputDecoration => InputDecoration(
    counterText: '',
    filled: true,
    fillColor: AppColors.background,
    contentPadding: EdgeInsets.zero,
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
  );

  Widget buildCodeInputField({
    required List<TextEditingController> controllers,
    required List<FocusNode> focusNodes,
    required void Function(String value, int index) onDigitChanged,
    int length = 6,
    double fieldSize = AppSizes.textSizeXXXLarge,
    double fieldHeight = AppSizes.buttonHeightLarge,
    double spacing = 4,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(length, (index) {
        return Container(
          width: fieldSize,
          height: fieldHeight,
          margin: EdgeInsets.symmetric(horizontal: spacing),
          child: TextFormField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: AppText.bodyExtraLarg,
            decoration: codeInputDecoration,
            validator: (value) {
              if (value == null || value.isEmpty) return '';
              return null;
            },
            onChanged: (value) => onDigitChanged(value, index),
          ),
        );
      }),
    );
  }
}
