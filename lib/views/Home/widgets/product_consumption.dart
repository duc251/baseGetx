import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_spacing.dart';
import '../../../common/constants/app_typography.dart';

class ProductConsumption extends StatelessWidget {
  const ProductConsumption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(sp16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(sp8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sản phẩm tiêu thụ trong tháng", style: AppTypography.h5),
          const SizedBox(height: sp16),
          Center(
              child: Text("Chưa có số liệu".tr,
                  style: AppTypography.p5.copyWith(color: AppColors.greyColor)))
          // ListView.builder(
          //   itemCount: 3,
          //   shrinkWrap: true,
          //   itemBuilder: (context, index) {
          //     return Padding(
          //       padding: EdgeInsets.only(bottom: index != 2 ? sp8 : 0),
          //       child: Container(
          //         padding: const EdgeInsets.all(sp16),
          //         decoration: BoxDecoration(
          //           color: AppColors.bg_4,
          //           borderRadius: BorderRadius.circular(sp8),
          //         ),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: const [
          //                 Text("Thạch natty khoai mon",
          //                     style: AppTypography.p6),
          //                 SizedBox(height: sp8),
          //                 Text("Tháng này: 1000", style: AppTypography.p7),
          //               ],
          //             ),
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.end,
          //               children: [
          //                 Row(
          //                   children: [
          //                     SvgPicture.asset(
          //                       '${AssetsPath.icon}/ic_arrow_down.svg',
          //                     ),
          //                     const SizedBox(width: sp4),
          //                     const Text("8%", style: AppTypography.p5),
          //                   ],
          //                 ),
          //                 const SizedBox(height: sp8),
          //                 const Text("Tháng trước: 1000",
          //                     style: AppTypography.p7),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // )
        ],
      ),
    );
  }
}
