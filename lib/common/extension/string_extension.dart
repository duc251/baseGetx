import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../widgets/status_widget.dart';

extension StringExtension on String {
  Widget get getStatusWidget {
    switch (this) {
      case "DRAFT":
        return const StatusWidget(
          title: "Dự thảo",
          backgroundColor: AppColors.yellow_2,
          titleColor: AppColors.yellow_1,
        );
      case "COUNTING":
        return const StatusWidget(
          title: "Đang đếm",
          backgroundColor: AppColors.borderColor_1,
          titleColor: AppColors.blackColor,
        );
      case "CONFIRM":
        return const StatusWidget(
          title: "Đã xác nhận",
          backgroundColor: AppColors.blue_2,
          titleColor: AppColors.blue_1,
        );
      case "DONE":
        return const StatusWidget(
          title: "Hoàn thành",
          backgroundColor: AppColors.green_2,
          titleColor: AppColors.green_1,
        );
      case "EXPORTED":
        return const StatusWidget(
          title: "Đã xuất",
          backgroundColor: AppColors.green_2,
          titleColor: AppColors.green_1,
        );
      case "CANCEL":
        return const StatusWidget(
          title: "Hết hiệu lực",
          backgroundColor: AppColors.red_2,
          titleColor: AppColors.red_1,
        );
    }
    return const SizedBox.shrink();
  }
}
