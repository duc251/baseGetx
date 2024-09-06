import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import 'custom_button.dart';

class TwoButtonBox extends StatelessWidget {
  final String? extraTitle;
  final String? mainTitle;
  final VoidCallback? extraOnTap;
  final VoidCallback? mainOnTap;
  final bool isDisable;
  final BorderRadiusGeometry? borderRadius;

  const TwoButtonBox({
    Key? key,
    this.extraTitle = '',
    this.mainTitle = '',
    this.extraOnTap,
    this.mainOnTap,
    this.borderRadius,
    this.isDisable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(sp16),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: AppColors.whiteColor,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            spreadRadius: 1,
            blurRadius: 15,
            offset: Offset(0, 0.3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: ExtraButton(
              title: extraTitle ?? 'Từ chối'.tr,
              onTap: () {
                extraOnTap?.call();
              },
              borderColor: AppColors.borderColor_4,
              largeButton: true,
              icon: null,
            ),
          ),
          const SizedBox(width: sp16),
          Expanded(
            flex: 1,
            child: MainButton(
              isDisable: isDisable,
              title: mainTitle ?? 'Phê duyệt'.tr,
              onTap: () {
                isDisable ? mainOnTap?.call() : null;
              },
              largeButton: true,
              icon: null,
            ),
          ),
        ],
      ),
    );
  }
}
