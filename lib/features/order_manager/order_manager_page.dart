import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhe_ctv/common/util/dialog_utils.dart';
import 'package:lhe_ctv/features/order_manager/widgets/order_infor/order_infor_page.dart';
import '../../../common/widgets/debouncer.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_typography.dart';
import '../../common/widgets/base_drop_down_box.dart';
import '../../common/widgets/base_textfield.dart';
import '../../data/models/order_model.dart';
import 'data/order_controller.dart';

class OrderManager extends StatefulWidget {
  const OrderManager({Key? key}) : super(key: key);

  @override
  State<OrderManager> createState() => _OrderManagerState();
}

class _OrderManagerState extends State<OrderManager> {
  late FocusNode _focusNode;
  late ScrollController _scrollController;
  late InfiniteListController<OrderModel> _infiniteListController;
  late Debouncer _debouncer;
  final controller = Get.put(OrderController());
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _debouncer = Debouncer();
    _infiniteListController = InfiniteListController.init();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const CustomAppBar(
        hasBack: true,
        title: "Danh sách đơn bán hàng",
        trailingIcons: [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: sp16),
        child: RefreshIndicator(
          onRefresh: () async {
            _infiniteListController.onRefresh();
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: sp24),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ValidateTextField(
                        focusNode: _focusNode,
                        backgroundColor: whiteColor,
                        onClear: () {
                          controller.search = '';
                          _infiniteListController.onRefresh();
                        },
                        hintText: "Tìm kiếm đơn bán hàng".tr,
                        hintStyle: p6.copyWith(color: greyColor),
                        emptySuffixIcon: const Icon(Icons.search,
                            color: greyColor, size: sp20),
                        onChanged: (value) {
                          controller.search = value;
                          _debouncer.run(() {
                            _infiniteListController.onRefresh();
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Image.asset(
                      "assets/imgs/sort.png",
                      width: 41,
                    )
                  ],
                ),
                const SizedBox(height: 24),
                Obx(() => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          4,
                          (index) => InkWell(
                            onTap: () {
                              _infiniteListController.onRefresh();
                              controller.indexFilter.value = index - 1;
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: controller.indexFilter.value == index - 1
                                    ? AppColors.accentColor_8
                                    : Colors.white,
                              ),
                              child: Text(
                                controller.listFilter[index],
                                style: AppTypography.p6.copyWith(
                                    color: controller.indexFilter.value ==
                                            index - 1
                                        ? Colors.white
                                        : greyColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
                const SizedBox(height: 24),
                OrderItemRow(
                  infiniteListController: _infiniteListController,
                  onDelete: () {
                    DialogUtils.showErrorDialog(
                      context,
                      label: "Lý do huỷ đơn hàng",
                      widgetContent: BaseDropDownBox(
                        hintText: "Nhập hoặc chọn lý do đã có sẵn",
                        listItems: controller.listSelectModel,
                        selectedItem: (item) {
                          controller.reason = item.label;
                        },
                        isOverlayOpened: (value) {},
                        onClear: () {
                          controller.reason = "";
                        },
                        validator: (value) {
                          if ((value?.isEmpty ?? false)) {
                            return "Bạn cần điền thông tin này".tr;
                          }
                          return null;
                        },
                      ),
                    );
                  },
                  orderModel: OrderModel(),
                ),
                const SizedBox(
                  height: 120,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderItemRow extends StatelessWidget {
  const OrderItemRow({
    super.key,
    required this.orderModel,
    required this.infiniteListController,
    required this.onDelete,
  });
  final OrderModel orderModel;
  final VoidCallback onDelete;
  final InfiniteListController<OrderModel> infiniteListController;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => OrderInforPage(
            infiniteListController: infiniteListController,
            ondelete: onDelete,
            orderModel: orderModel,
          )),
      child: baseContainer(
        Column(
          children: [
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "order" ?? "",
                          style: AppTypography.p5.copyWith(color: greyColor),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          " order.orderCode " ?? "",
                          style: AppTypography.p5.copyWith(color: mainColor),
                        ),
                      ],
                    ),
                    // const Spacer(),
                    Container(
                      height: 37,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: orderModel.getStatusColor2(0),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        orderModel.getStatusString(1),
                        style: p5.copyWith(color: orderModel.getStatusColor(1)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Số điện thoại: ",
                      style: AppTypography.p7.copyWith(color: greyColor),
                    ),
                    Text(
                      " order.phoneNumber" ?? "",
                      style: AppTypography.p7,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      "Xe: $orderModel: ",
                      style: AppTypography.p7.copyWith(color: greyColor),
                    ),
                    Text(
                      "order.licensePlates" ?? "",
                      style: AppTypography.p7,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
