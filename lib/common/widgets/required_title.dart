import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/app_typography.dart';

class RequiredTitle extends StatelessWidget {
  final String title;

  const RequiredTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppTypography.p5),
        Text(
          " *".tr,
          style: AppTypography.p5.copyWith(color: AppColors.red_1),
        ),
      ],
    );
  }
}
