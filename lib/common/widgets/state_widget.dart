import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

class StateWidget extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final String? title;
  final TextStyle? style;
  final VoidCallback? onTap;
  final bool isSelected;

  const StateWidget({
    super.key,
    this.margin,
    this.padding,
    this.color,
    this.title,
    this.style,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        margin: margin ?? const EdgeInsets.only(right: sp8),
        padding: padding ??
            const EdgeInsets.symmetric(vertical: sp8, horizontal: sp12),
        decoration: BoxDecoration(
          color: isSelected
              ? color ?? AppColors.accentColor_8
              : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(sp8),
        ),
        child: Text(
          title ?? '',
          style: style ??
              AppTypography.p5.copyWith(
                color: isSelected ? AppColors.whiteColor : AppColors.greyColor,
              ),
        ),
      ),
    );
  }
}
