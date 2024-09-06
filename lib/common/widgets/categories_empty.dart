import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import '../constants/assets_path.dart';

class CategoriesEmpty extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const CategoriesEmpty({
    super.key,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: sp16, vertical: sp24),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(sp8),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            '${AssetsPath.icon}/ic_lh.svg',
          ),
          const SizedBox(height: sp8),
          Text(
            title ?? "Danh mục".tr,
            style: AppTypography.p4,
          ),
          const SizedBox(height: sp8),
          subtitle != null
              ? Text(
                  "Tạo danh mục sản phẩm mới để hiển thị và quản lý danh mục"
                      .tr,
                  textAlign: TextAlign.center,
                  style: AppTypography.p4.copyWith(color: AppColors.greyColor),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: sp24),
          subtitle != null
              ? InkWell(
                  onTap: () {},
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: sp16, vertical: sp12),
                      decoration: BoxDecoration(
                        color: AppColors.accentColor_4,
                        borderRadius: BorderRadius.circular(sp8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            '${AssetsPath.icon}/ic_add.svg',
                          ),
                          const SizedBox(width: sp8),
                          Text(
                            "Tạo danh mục mới",
                            style: AppTypography.h6
                                .copyWith(color: AppColors.whiteColor),
                          ),
                        ],
                      )),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
