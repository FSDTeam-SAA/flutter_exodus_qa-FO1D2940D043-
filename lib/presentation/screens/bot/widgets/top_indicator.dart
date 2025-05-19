import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:flutter/material.dart';

class TopIndicator extends Decoration {
  const TopIndicator();

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TopIndicatorPainter();
  }
}

class _TopIndicatorPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint =
        Paint()
          ..color = AppColors.secondary
          ..style = PaintingStyle.fill;

    // Adjust these two values to change the indicator weight:
    final indicatorHeight = 4.0; // This controls the thickness/weight
    final cornerRadius = 4.0; // This should match or be proportional to height

    final rect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      configuration.size!.width,
      indicatorHeight,
    );

    final radius = Radius.circular(cornerRadius);

    final rrect = RRect.fromRectAndCorners(
      rect,
      bottomLeft: radius,
      bottomRight: radius,
    );

    canvas.drawRRect(rrect, paint);
  }
}
