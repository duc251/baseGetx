import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../common/base/base_container.dart';
import '../../../common/util/enum/tab_item.dart';
import '../../../components/chart/profit_chart.dart';
import '../../../components/chart/sale_chart.dart';
import '../../../components/maps/index.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_size_device.dart';
import '../../../common/constants/app_spacing.dart';
import '../../../common/constants/app_typography.dart';
import '../../../common/routes/app_routes.dart';
import '../../../views/Home/widgets/product_consumption.dart';
import '../model/app_model.dart';
import 'app_controller.dart';

Widget buildAppItem(BuildContext context, Widget logo, String title,
    dynamic routeName, int index) {
  return InkWell(
    onTap: () {
      if (routeName is TabItemCode) {
        Get.toNamed(Routes.routeTabView, arguments: routeName);
      } else {
        Get.toNamed('$routeName');
      }
      // routeName == ''
      //     ? Get.toNamed(Routes.routeTabs, arguments: '$index')
      //     : Get.toNamed('$routeName');
    },
    child: Column(
      children: [
        SizedBox(height: (widthDevice(context) - 15) / 4, child: logo),
        Text(
          title,
          style: AppTypography.p8.copyWith(color: AppColors.whiteColor),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}

Widget buildSlider_1(BuildContext context, List<AppModel> listApp) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.6,
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
      ),
      itemCount: listApp.length,
      itemBuilder: (context, index) => buildAppItem(
        context,
        listApp[index].logo,
        listApp[index].title,
        listApp[index].routeName,
        index,
      ),
    ),
  );
}

Widget buildSlider_2(
    BuildContext context, AppController appController, String name) {
  String getGreeting() {
    var currentTime = DateTime.now();
    var currentHour = currentTime.hour;

    if (currentHour >= 5 && currentHour < 12) {
      return "Chào buổi sáng";
    } else if (currentHour >= 12 && currentHour < 18) {
      return "Chào buổi chiều";
    } else {
      return "Chào buổi tối";
    }
  }

  return Padding(
    padding: const EdgeInsets.all(16),
    child: ListView(
      children: [
        // Row(
        //   children: [
        //     Expanded(
        //       flex: 1,
        //       child: Image.asset('${AssetsPath.image}/dashboard/sale.png', fit: BoxFit.cover,)),
        //     const SizedBox(width: sp16),
        //     Expanded(
        //       flex: 1,
        //       child: Image.asset('${AssetsPath.image}/dashboard/owe.png', fit: BoxFit.cover,))
        //   ],
        // ),
        Container(
          padding: const EdgeInsets.all(sp16),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(sp8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getGreeting(),
                    style:
                        AppTypography.p7.copyWith(color: AppColors.greyColor),
                  ),
                  const SizedBox(height: sp8),
                  Text(
                    name,
                    style:
                        AppTypography.h6.copyWith(color: AppColors.blackColor),
                  )
                ],
              ),
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.routeEcommerceStore);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(sp16),
                      decoration: const BoxDecoration(
                        color: AppColors.borderColor_1,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        'assets/imgs/ic_store.svg',
                        width: sp16,
                      ),
                    ),
                  ),
                  // PositionedDirectional(
                  //   top: 0,
                  //   end: 0,
                  //   child: Container(
                  //     height: sp8,
                  //     width: sp8,
                  //     decoration: const BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: AppColors.red_1,
                  //     ),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: sp16),
        const ProfitChart(),
        // Plan(context, appController.dataFinancialSituation),
        const SizedBox(height: sp16),
        const RevenueChart(),
        const SizedBox(height: sp16),
        const ProductConsumption(),
      ],
    ),
  );
}

Widget financialSituation(BuildContext context, List data) {
  return BaseContainer(
      context,
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tình hình tài chính',
                style: AppTypography.h4,
              ),
              // SizedBox(
              //   width: 120,
              //   child: BaseSelect(list: ['Tháng này'],select: 'Tháng này',handleSelect: () {}, hint: ''))
            ],
          ),
          const SizedBox(height: sp16),
          SizedBox(
            width: widthDevice(context) - 64,
            height: 114,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: sp16),
              itemBuilder: (context, index) => ItemHomeContainer(data[index]),
              itemCount: data.length,
            ),
          )
        ],
      ));
}

Widget Plan(BuildContext context, List data) {
  return BaseContainer(
      context,
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kế hoạch',
                style: AppTypography.h4,
              ),
              // SizedBox(
              //   width: 120,
              //   child: BaseSelect(list: ['Tháng này'],select: 'Tháng này',handleSelect: () {},hint: ''))
            ],
          ),
          const SizedBox(height: sp16),
          SizedBox(
            width: widthDevice(context) - 64,
            height: 114,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: sp16),
              itemBuilder: (context, index) => ItemHomeContainer(data[index]),
              itemCount: data.length,
            ),
          )
        ],
      ));
}

Widget SalesNetwork(BuildContext context) {
  return BaseContainer(
    context,
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Mạng lưới bán hàng', style: AppTypography.h3),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0),
              ),
              onPressed: () {
                Get.toNamed(Routes.routeGoogleMapScreen);
              },
              child: const Text('Chi tiết'),
            ),
          ],
        ),
        const SizedBox(height: sp16),
      ],
    ),
  );
}

Widget ItemHomeContainer(Map<String, dynamic> data) {
  return Container(
    width: 208,
    height: 114,
    padding: const EdgeInsets.all(sp16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(sp8),
      color: AppColors.bg_4,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data['title'],
          style: AppTypography.p5,
        ),
        const SizedBox(height: sp12),
        Text(
          data['value'],
          style: AppTypography.h4,
        )
      ],
    ),
  );
}
