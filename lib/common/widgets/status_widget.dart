import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

class StatusWidget extends StatelessWidget {
  final String? title;
  final Color? titleColor;
  final Color? backgroundColor;

  const StatusWidget({
    super.key,
    this.title,
    this.titleColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(sp8),
      ),
      padding: const EdgeInsets.symmetric(vertical: sp8, horizontal: sp16),
      child: Center(
        child: Text(
          title ?? '',
          style: AppTypography.p5.copyWith(color: titleColor),
        ),
      ),
    );
  }
}
