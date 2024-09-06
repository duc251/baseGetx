import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lhe_ctv/common/constants/app_typography.dart';
import 'package:lhe_ctv/features/customer_manager/widgets/order_page.dart';
import '../../../../components/item/row.dart';
import '../../../../data/models/customer_model/customer_model.dart';
import '../../data/Customer_controller.dart';
import '../avatar_border.dart';

class CustomerInforPage extends StatelessWidget {
  CustomerInforPage(
      {super.key,
      required this.customerModel,
      required this.ondelete,
      required this.infiniteListController}) {
    // controller.getCustomerTransportModels(customerModel.id!);
  }
  final CustomerModel customerModel;
  final controller = Get.find<CustomerController>();
  final VoidCallback ondelete;
  final InfiniteListController infiniteListController;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.white,
          height: 77,
          padding: const EdgeInsets.all(16),
          child: GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: sp12),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(sp8),
              ),
              child: Center(
                child: Text(
                  "Tạo đơn bán hàng",
                  style: h6.copyWith(
                    color: whiteColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      appBar: const CustomAppBar(hasBack: true, title: "Chi tiết khách hàng"),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
          child: ListView(
            children: [
              baseContainer(Column(
                children: [
                  Row(
                    children: [
                      AvatarBorder(
                        pathAvatar: customerModel.getProfileValue(),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customerModel.fullname ?? "",
                            style: p3,
                          ),
                          Text(
                            customerModel.acountCode ?? "",
                            style: p5.copyWith(color: mainColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 37,
                    margin: const EdgeInsets.only(top: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: borderColor_2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/ic_phone2.svg'),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          "Liên hệ với khách hàng",
                          style: p5,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              const SizedBox(
                height: 16,
              ),
              baseContainer(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildRowItem(
                        title: "Email", content: customerModel.email ?? ""),
                    const SizedBox(height: sp8),
                    buildRowItem(
                        title: "Số điện thoại",
                        content: customerModel.username ?? ""),
                    const SizedBox(height: sp8),
                    buildRowItem(
                        title: "Ngày sinh",
                        content: customerModel.getProfileValue(
                                keyword: "date_of_b") ??
                            ""),
                    const SizedBox(height: sp8),
                    buildRowItem(title: "Địa chỉ", content: ""),
                    const SizedBox(height: sp8),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              baseContainer(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tổng quan đơn hàng",
                    style: AppTypography.p1,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: baseContainer(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "20",
                                style: AppTypography.h3,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Chờ xác nhận',
                                style: AppTypography.p9,
                              )
                            ],
                          ),
                          height: 88,
                          color: const Color(0xfff5f5f5),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => Get.to(() => const OrderPage()),
                          child: baseContainer(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "20",
                                  style:
                                      AppTypography.h3.copyWith(color: red_1),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Đơn hủy',
                                  style: AppTypography.p9,
                                )
                              ],
                            ),
                            height: 88,
                            color: const Color(0xfff5f5f5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: baseContainer(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "20",
                                style: AppTypography.h3,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Hoàn thành',
                                style: AppTypography.p9,
                              )
                            ],
                          ),
                          height: 88,
                          color: const Color(0xfff5f5f5),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      const Spacer()
                    ],
                  ),
                ],
              )),
            ],
          )),
    );
  }
}
