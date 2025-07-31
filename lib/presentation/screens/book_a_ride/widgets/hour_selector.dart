import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/core/constants/app/app_sizes.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app/app_colors.dart';
import '../../../../core/theme/text_style.dart';
import '../controllers/hour_selector_controller.dart';

class HourSelector extends StatefulWidget {
  final HourSelectorController controller;

  const HourSelector({super.key, required this.controller});

  @override
  State<HourSelector> createState() => _HourSelectorState();
}

class _HourSelectorState extends State<HourSelector> {
  final ValueNotifier<bool> _isSubscribed = ValueNotifier(false);

  @override
  void dispose() {
    _isSubscribed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([widget.controller, _isSubscribed]),
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: AppSizes.paddingAllSmall,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: AppSizes.borderRadiusMedium,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // _iconButton(Icons.remove, controller.decrease, longPress: controller.resetHours),
                    _RemoveButton(
                      onPressed: widget.controller.decrease,
                      onLongPress: widget.controller.resetHours,
                      controller: widget.controller,
                    ),
                    Gap.w8,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: AppSizes.borderRadiusSmall,
                      ),
                      child: Text(
                        "${widget.controller.hours.toStringAsFixed(1)}hr",
                        style: AppText.bodyMedium.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                    ),

                    Gap.w8,
                    _iconButton(
                      Icons.add,
                      widget.controller.increase,
                      longPress: null,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                "Amount: \$${widget.controller.subtotal.toStringAsFixed(0)}",
                style: AppText.h2.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: AppSizes.paddingHorizontalLarge,
              child: Center(
                child: Text(
                  "You need to pay \$75.00 dollars per additional 1.0hr",
                  style: AppText.bodyRegular.copyWith(
                    color: AppColors.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Gap.h16,
            _priceRow("Subtotal", widget.controller.subtotal),

            Gap.h16,
            _priceRow("Tax", widget.controller.tax),

            Gap.h16,
            Divider(thickness: 0.8, color: AppColors.secondary),

            Gap.h16,
            _priceRow("Total", widget.controller.total),

            Gap.h40,
            _buildSubscriptionToggle(),
          ],
        );
      },
    );
  }

  Widget _iconButton(
    IconData icon,
    VoidCallback onPressed, {
    VoidCallback? longPress,
  }) {
    return InkWell(
      onTap: onPressed,
      onLongPress: longPress,
      borderRadius: AppSizes.borderRadiusSmall,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.background),
          borderRadius: AppSizes.borderRadiusSmall,
        ),
        child: Icon(icon, size: 16, color: AppColors.background),
      ),
    );
  }

  Widget _priceRow(String label, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppText.bodyRegular),
        Text("\$${value.toStringAsFixed(2)}", style: AppText.bodyRegular),
      ],
    );
  }

  Widget _buildSubscriptionToggle() {
    return ValueListenableBuilder<bool>(
      valueListenable: _isSubscribed,
      builder: (context, isSubscribed, _) {
        return GestureDetector(
          onTap: () => _isSubscribed.value = !isSubscribed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSubscribed ? AppColors.primary : AppColors.secondary,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8),
              color: AppColors.background,
            ),
            child: Row(
              children: [
                Icon(
                  isSubscribed
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: AppColors.secondary,
                  size: 20,
                ),
                Gap.w8,
                Text(
                  "With Subscription",
                  style: AppText.smallRegular.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RemoveButton extends StatefulWidget {
  final VoidCallback onPressed;
  final VoidCallback onLongPress;
  final HourSelectorController controller;

  const _RemoveButton({
    required this.onPressed,
    required this.onLongPress,
    required this.controller,
  });

  @override
  State<_RemoveButton> createState() => _RemoveButtonState();
}

class _RemoveButtonState extends State<_RemoveButton> {
  int _pressCount = 0;
  DateTime? _lastPressTime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed();
        _handlePressCount(context);
      },
      onLongPress: widget.onLongPress,
      borderRadius: AppSizes.borderRadiusSmall,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.background),
          borderRadius: AppSizes.borderRadiusSmall,
        ),
        child: const Icon(Icons.remove, size: 16, color: AppColors.background),
      ),
    );
  }

  void _handlePressCount(BuildContext context) {
    final now = DateTime.now();
    final isQuickPress =
        _lastPressTime != null &&
        now.difference(_lastPressTime!) < const Duration(seconds: 1);

    if (isQuickPress) {
      _pressCount++;
    } else {
      _pressCount = 1;
    }

    _lastPressTime = now;

    if (_pressCount >= 3 &&
        widget.controller.hours > widget.controller.minHours) {
      _showLongPressTip(context);
      _pressCount = 0; // Reset counter after showing tip
    }
  }

  void _showLongPressTip(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Tip: Long press to reset hours to minimum'),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
