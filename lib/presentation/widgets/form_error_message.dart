import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:flutter/material.dart';


class FormErrorMessage extends StatelessWidget {
  final String message;

  const FormErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.warningBackground.withAlpha((0.8 * 255).toInt()),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, color: AppColors.error),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: AppColors.error,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
