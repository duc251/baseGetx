import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import '../constants/assets_path.dart';

class DateSelectionWidget extends StatelessWidget {
  final String? label;
  final String? title;
  final VoidCallback? onTap;

  const DateSelectionWidget({
    super.key,
    this.label,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) Text(label!, style: AppTypography.p5),
        const SizedBox(height: sp4),
        Container(
          padding: const EdgeInsets.all(sp12),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(sp8),
            border: Border.all(color: AppColors.borderColor_2, width: 0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title ?? "Chọn thời gian".tr,
                style: AppTypography.p6.copyWith(
                  color: title != null
                      ? AppColors.blackColor
                      : AppColors.greyColor,
                ),
              ),
              if (title == null)
                SvgPicture.asset(
                  '${AssetsPath.icon}/ic_calendar_table.svg',
                )
              else
                GestureDetector(
                    onTap: () {
                      onTap?.call();
                    },
                    child: const Icon(Icons.close, size: 18))
            ],
          ),
        )
      ],
    );
  }
}
