import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';
import '../../../../common/constants/app_typography.dart';
import '../../../../components/item/row.dart';
import '../../../../data/models/order_model.dart';
import '../../data/order_controller.dart';
import '../update_order/update_order_page.dart';

class OrderInforPage extends StatelessWidget {
  OrderInforPage(
      {super.key,
      required this.orderModel,
      required this.ondelete,
      required this.infiniteListController}) {
    controller.getOrderModels(orderModel);
  }
  final OrderModel orderModel;
  final controller = Get.find<OrderController>();
  final VoidCallback ondelete;
  final InfiniteListController infiniteListController;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 77,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: ondelete,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: sp12),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: greyColor),
                    borderRadius: BorderRadius.circular(sp8),
                  ),
                  child: const Center(
                    child: Text("Hủy đơn hàng", style: h6),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => Get.to(() => UpdateOrderPage(
                      isCreate: false,
                      orderModel: orderModel,
                      infiniteListController: infiniteListController,
                    )),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: sp12),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(sp8),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Xác nhận",
                          style: h6.copyWith(
                            color: whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: const CustomAppBar(
          hasBack: true, title: "Chi tiết đơn bán hàng", trailingIcons: []),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
        child: ListView(
          children: [
            baseContainer(
              Column(
                children: [
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: orderModel.getStatusColor2(1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      orderModel.getStatusString(1),
                      style: p5.copyWith(color: orderModel.getStatusColor(1)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  buildRowItem(
                      title: "Mã đơn hàng",
                      content: "orderModel.orderName" ?? ""),
                  const SizedBox(height: sp8),
                  buildRowItem(
                      title: "Thời gian tạo",
                      content: "orderModel.phoneNumber" ?? ""),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            baseContainer(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRowItem(
                      title: "Tên khách",
                      content: "orderModel.orderName" ?? ""),
                  const SizedBox(height: sp8),
                  buildRowItem(
                      title: "Số điện thoại",
                      content: "orderModel.phoneNumber" ?? ""),
                  const SizedBox(height: sp8),
                  buildRowItem(
                      title: "Địa chỉ", content: "orderModel.passport" ?? ""),
                  const SizedBox(height: sp8),
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: borderColor_2),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/ic_phone2.svg'),
                        const Text(
                          "  Gọi tới khách hàng",
                          style: p5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            baseContainer(
              FixedTimeline.tileBuilder(
                mainAxisSize: MainAxisSize.min,
                theme: TimelineThemeData(
                    color: greyColor,
                    indicatorTheme: const IndicatorThemeData(size: 8),
                    connectorTheme: const ConnectorThemeData(space: 1)),
                builder: TimelineTileBuilder.connectedFromStyle(
                  contentsAlign: ContentsAlign.basic,
                  oppositeContentsBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('17/10\n 08:11'),
                  ),
                  contentsBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contents dfdfdfddsdsd $index',
                            style: AppTypography.p6.copyWith(
                                color: index == 0 ? green_1 : greyColor),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Bởi tài xế: ',
                                  style: AppTypography.p9
                                      .copyWith(color: greyColor),
                                ),
                                TextSpan(
                                  text: 'Nguyễn Văn Trung',
                                  style: AppTypography.p9
                                      .copyWith(color: blackColor),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  nodePositionBuilder: (context, index) {
                    return .17;
                  },
                  firstConnectorStyle: ConnectorStyle.transparent,
                  lastConnectorStyle: ConnectorStyle.transparent,
                  connectorStyleBuilder: (context, index) =>
                      ConnectorStyle.solidLine,
                  indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
                  itemCount: 8,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            baseContainer(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRowItem(
                      title: "Hình thức thanh toán",
                      content: "COD" ?? "",
                      contentTextStyle: AppTypography.h6.copyWith(
                        color: mainColor,
                      )),
                  const SizedBox(height: sp8),
                  buildRowItem(
                    title: "Hình thức vận chuyển",
                    content: "orderModel.phoneNumber" ?? "",
                    contentTextStyle:
                        AppTypography.h6.copyWith(color: mainColor),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            baseContainer(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sản phẩm",
                    style: p3,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const ProductItemRow(),
                  const SizedBox(
                    height: 16,
                  ),
                  buildRowText(
                    title: "Chi phí vận chuyển",
                    content: "12.000",
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  buildRowText(
                    title: "Tổng tiền",
                    styleTitle: AppTypography.p1,
                    content: "412.000",
                    style: AppTypography.p1.copyWith(color: mainColor),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductItemRow extends StatelessWidget {
  const ProductItemRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Chuối hoa quả',
              ),
              SizedBox(height: 8),
              Text(
                '100.000',
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                'X2',
              ),
              SizedBox(height: 8),
              Text(
                '200.000',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
