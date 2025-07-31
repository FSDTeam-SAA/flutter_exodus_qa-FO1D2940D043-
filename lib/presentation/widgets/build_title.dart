import 'package:flutter/material.dart';

import '../../core/constants/app/app_sizes.dart';
import '../../core/theme/text_style.dart';

class TitleTextWidget extends StatelessWidget {
  final String title;
  final bool usePadding;

  const TitleTextWidget({super.key, required this.title, this.usePadding = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: usePadding ? AppSizes.paddingHorizontalExtraMedium : EdgeInsets.zero,
      child: Text(title, style: AppText.bodySemiBold),
    );
  }
}
