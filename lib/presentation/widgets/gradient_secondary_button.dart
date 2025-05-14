import 'package:exodus/core/constants/app/app_sizes.dart';
import 'package:flutter/material.dart';

class GradientButtonSecondary extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Gradient gradient;
  final bool isPrimary;
  final double height;
  // final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const GradientButtonSecondary({
    super.key,
    required this.onPressed,
    required this.child,
    required this.gradient,
    this.isPrimary = true,
    this.height = AppSizes.buttonHeightSmall,
    // this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    // return isPrimary ? _buildPrimaryButton() : _buildSecondaryButton();

    return Container(
      decoration: BoxDecoration(
        borderRadius: AppSizes.borderRadiusMedium,
        gradient: gradient,
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0), // Border width
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: AppSizes.borderRadiusMedium,
          ),
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.transparent),
              minimumSize: Size.fromHeight(height),
              padding: padding,
              shape: RoundedRectangleBorder(
                borderRadius: AppSizes.borderRadiusMedium,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
    // return Container(
    //   decoration: BoxDecoration(
    //     gradient: gradient,
    //     borderRadius: AppSizes.borderRadiusMedium,
    //   ),
    //   child: ElevatedButton(
    //     onPressed: onPressed,
    //     style: ElevatedButton.styleFrom(
    //       backgroundColor: Colors.transparent,
    //       shadowColor: Colors.transparent,
    //       minimumSize: Size.fromHeight(height),
    //       padding: padding,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(AppSizes.buttonHeightLarge),
    //       ),
    //     ),
    //     child: child,
    //   ),
    // );
  }
}
