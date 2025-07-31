import 'package:flutter/material.dart';

class ArrowIcon extends StatelessWidget {
  final Color? color;
  final double height;
  final double width;

  const ArrowIcon({
    super.key,
    this.color,
    this.height = 15,
    this.width = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/icons/from_to.png",
      color: color,
      height: height,
      width: width,
    );
  }
}
