import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';

class DevelopingFeature extends StatelessWidget {
  const DevelopingFeature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(title: 'Cài đặt'.tr, hasBack: true),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 120),
            Image.asset('${AssetsPath.image}/img_developing.png'),
            const SizedBox(height: 25),
            Text(
              "Tính năng đang phát triển".tr,
              style: AppTypography.h2,
            ),
          ],
        ),
      ),
    );
  }
}
