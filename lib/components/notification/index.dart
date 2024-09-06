import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../common/base/base_button.dart';
import '../../common/util/enum/status_noti.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_size_device.dart';
import '../../common/constants/app_spacing.dart';
import '../../common/constants/app_typography.dart';
import '../../common/constants/assets_path.dart';

Widget PopNotification(
    BuildContext context, String content, Function? click, StatusChat status) {
  return Center(
    child: Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: sp24, horizontal: sp16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(sp8),
        ),
        width: max(widthDevice(context) - sp32, 343),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (status == StatusChat.LOADING)
              const CircularProgressIndicator()
            else
              CircleAvatar(
                radius: 30,
                backgroundColor: status == StatusChat.SUCCESS
                    ? AppColors.green_2
                    : status == StatusChat.WARNING
                        ? AppColors.yellow_2
                        : AppColors.red_2,
                child: SvgPicture.asset(
                  '${AssetsPath.image}/${status == StatusChat.SUCCESS ? 'noti/success.svg' : status == StatusChat.WARNING ? 'noti/warning.svg' : 'noti/error.svg'}',
                ),
              ),
            const SizedBox(height: sp24),
            Text('Thông báo', style: AppTypography.h3),
            const SizedBox(height: sp12),
            Text(
              content,
              style: AppTypography.p4.copyWith(color: AppColors.greyColor),
              textAlign: TextAlign.center,
            ),
            if (status != StatusChat.LOADING) const SizedBox(height: sp24),
            if (status != StatusChat.LOADING)
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Extrabutton(
                      title: 'Quay lại',
                      event: () {
                        Get.back();
                      },
                      borderColor: AppColors.borderColor_4,
                      largeButton: true,
                      icon: null,
                    ),
                  ),
                  if (click != null) const SizedBox(width: sp16),
                  if (click != null)
                    Expanded(
                      flex: 1,
                      child: MainButton(
                        title: 'Xác nhận',
                        event: () {
                          click();
                        },
                        largeButton: true,
                        icon: null,
                      ),
                    ),
                ],
              )
          ],
        ),
      ),
    ),
  );
}
