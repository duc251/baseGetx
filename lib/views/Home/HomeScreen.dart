import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lhe_ctv/common/constants/app_typography.dart';
import 'package:lhe_ctv/common/util/api.dart';
import 'package:lhe_ctv/components/item/row.dart';
import 'package:lhe_ctv/features/customer_manager/customer_manager_page.dart';
import 'package:lhe_ctv/features/order_manager/order_manager_page.dart';
import 'package:lhe_ctv/features/product_manager/product_manager_page.dart';
import 'package:lhe_ctv/views/Home/home_controller.dart';
import 'package:lhe_ctv/views/Home/sales_report/sale_analysis_page.dart';
import 'package:lhe_ctv/views/Home/sales_report/sale_report_page.dart';

import '../../common/base/base_bottomBar.dart';
import '../../common/services/auth_service.dart';
import '../../common/util/enum/tab_item.dart';
import '../../features/account/views/index_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(HomeController());
  final authUser = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        elevation: 0,
        title: InkWell(
          onTap: () => Get.to(() => const AccountView()),
          child: Obx(() => Text(
                controller.indexPage.value == 0
                    ? authUser.user?.value.fullname ?? "-"
                    : 'Báo cáo',
                style: AppTypography.h5,
              )),
        ),
        actions: [
          SvgPicture.asset(
            '${AssetsPath.icon}/ic_bell.svg',
          ),
          const SizedBox(width: sp24),
          SvgPicture.asset(
            'assets/icons/more.svg',
          ),
          const SizedBox(width: sp16),
        ],
      ),
      bottomNavigationBar: Obx(() => buildBottomBar(
            context,
            controller.indexPage.value == 0
                ? TabItemCode.order
                : TabItemCode.report,
            (TabItemCode code) {
              if (code == TabItemCode.order) {
                controller.indexPage.value = 0;
              } else {
                controller.indexPage.value = 1;
              }
            },
          )),
      body: Obx(() => IndexedStack(
            index: controller.indexPage.value,
            children: const [Manager(), ReportPage()],
          )),
    );
  }
}

class Manager extends StatelessWidget {
  const Manager({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => Get.to(() => const OrderManager()),
                  child: baseContainer(
                      height: 88.sp,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset('assets/icons/oder2.svg'),
                          Text(
                            "Đơn bán hàng",
                            style: AppTypography.p5,
                          )
                        ],
                      )),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: baseContainer(
                    height: 88.sp,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/imgs/order.png'),
                        Text(
                          "Đơn đặt hàng",
                          style: AppTypography.p5,
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => Get.to(() => const ProductManager()),
                  child: baseContainer(
                      height: 88.sp,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset('assets/icons/box.svg'),
                          Text(
                            "Quản lý sản phẩm",
                            style: AppTypography.p5,
                          )
                        ],
                      )),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: InkWell(
                  onTap: () => Get.to(() => const CustomerManager()),
                  child: baseContainer(
                      height: 88.sp,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset('assets/icons/ic_user.svg'),
                          Text(
                            "Quản lý khách hàng",
                            style: AppTypography.p5,
                          )
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          baseContainer(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Doanh thu",
                        style: AppTypography.h4,
                      ),
                      InkWell(
                        onTap: () => Get.to(() => SalesReportView()),
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                                color: blue_2,
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Xem chi tiết",
                              style: AppTypography.p5.copyWith(color: blue_1),
                            )),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  baseContainer(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Doanh thu tháng này",
                            style: AppTypography.p4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "500 triệu",
                            style: AppTypography.h2,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.arrow_upward,
                                color: green_1,
                              ),
                              Text(
                                " 5% ",
                                style:
                                    AppTypography.p1.copyWith(color: green_1),
                              ),
                              Text("So với tháng trước",
                                  style: AppTypography.p5
                                      .copyWith(color: greyColor)),
                            ],
                          )
                        ],
                      ),
                      color: bg_4)
                ],
              ),
              height: 236.sp),
          const SizedBox(
            height: 16,
          ),
          baseContainer(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phân tích bán hàng",
                      style: AppTypography.h4,
                    ),
                    InkWell(
                      onTap: () => Get.to(() => SalesAnalysysView()),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                              color: blue_2,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "Xem chi tiết",
                            style: AppTypography.p5.copyWith(color: blue_1),
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: baseContainer(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        Api.defaultLogo,
                                        width: 48,
                                        height: 48,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "Thạc Caramel",
                                            style: AppTypography.p5,
                                          ),
                                          Text(
                                            "Thạc Caramel",
                                            style: AppTypography.p5,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  buildRowText(
                                      title: "Đã bán",
                                      content: "1.000.000 Thùng"),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  buildRowText(
                                      title: "Doanh thu", content: "50 tỷ"),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  buildRowText(
                                      title: "So với tháng trước",
                                      content: "Tăng 22%",
                                      style: AppTypography.p5
                                          .copyWith(color: green_1)),
                                ],
                              ),
                              color: bg_4,
                              width: 266.sp),
                        );
                      },
                      itemCount: 5,
                      scrollDirection: Axis.horizontal),
                ),
              ],
            ),
            height: 292.sp,
          ),
        ],
      ),
    );
  }
}
