import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/constants/app_typography.dart';
import '../../../common/util/dialog_utils.dart';
import '../../../common/widgets/date_selection_widget.dart';
import '../home_controller.dart';
import '../widgets/chart_view.dart';

class SalesReportView extends StatelessWidget {
  SalesReportView({super.key});
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const CustomAppBar(
        hasBack: true,
        title: "Báo cáo doanh thu",
        trailingIcons: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            const SizedBox(
              height: 8,
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
                    "Báo cáo doanh thu",
                    style: AppTypography.p5,
                  ),
                  const SizedBox(
                    height: 16,
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
