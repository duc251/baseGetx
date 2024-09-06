import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/constants/app_typography.dart';
import '../../../common/util/dialog_utils.dart';
import '../../../common/widgets/date_selection_widget.dart';
import '../home_controller.dart';
import '../widgets/chart_view.dart';

class SalesAnalysysView extends StatelessWidget {
  SalesAnalysysView({super.key});
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const CustomAppBar(
        hasBack: true,
        trailingIcons: [],
        title: "Phân tích bán hàng",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
                onTap: () async {
                  await DialogUtils.showCalendarDialog(
                    context,
                    selectedDate: controller.selectedDate,
                    onConfirm: (value) {
                      controller.onSelectDate(value);
                    },
                  );
                },
                child: Obx(() => DateSelectionWidget(
                      title: controller.selectedDate[0],
                      onTap: () {},
                    ))),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Chỉ số quan trọng",
                style: AppTypography.p3,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: baseContainer(Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Đơn hàng",
                            style: AppTypography.p7,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "13",
                            style: AppTypography.p1,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_downward,
                            color: red_1,
                            size: 19,
                          ),
                          Text(
                            '2%',
                            style: AppTypography.p5.copyWith(color: red_1),
                          )
                        ],
                      )
                    ],
                  )),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: baseContainer(Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Doanh số",
                            style: AppTypography.p7,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "130 Tr",
                            style: AppTypography.p1,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_upward,
                            color: green_1,
                            size: 19,
                          ),
                          Text(
                            '5%',
                            style: AppTypography.p5.copyWith(color: green_1),
                          )
                        ],
                      )
                    ],
                  )),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: baseContainer(Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Người truy cập",
                            style: AppTypography.p7,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "13",
                            style: AppTypography.p1,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_downward,
                            color: red_1,
                            size: 19,
                          ),
                          Text(
                            '2%',
                            style: AppTypography.p5.copyWith(color: red_1),
                          )
                        ],
                      )
                    ],
                  )),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: baseContainer(Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sản phẩm",
                            style: AppTypography.p7,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "13",
                            style: AppTypography.p1,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_downward,
                            color: red_1,
                            size: 19,
                          ),
                          Text(
                            '2%',
                            style: AppTypography.p5.copyWith(color: red_1),
                          )
                        ],
                      )
                    ],
                  )),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 320,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Đơn hàng",
                    style: AppTypography.p5,
                  ),
                  const Expanded(child: LineChartSample2()),
                  Row(
                    children: [
                      const Spacer(
                        flex: 2,
                      ),
                      const CircleAvatar(
                        backgroundColor: mainColor,
                        radius: 5,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Tháng này",
                        style: AppTypography.p9,
                      ),
                      const Spacer(),
                      const CircleAvatar(
                        backgroundColor: greyColor,
                        radius: 5,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Tháng trước",
                        style: AppTypography.p9,
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
