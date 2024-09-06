import 'dart:io';

import 'package:base_lhe/base_lhe.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/util/api.dart';
import '../../../../common/widgets/base_textfield.dart';
import '../../../../data/models/order_model.dart';
import '../../data/update_order_controller.dart';

class UpdateOrderPage extends StatelessWidget {
  UpdateOrderPage(
      {Key? key,
      this.isCreate = true,
      this.orderModel,
      required this.infiniteListController})
      : super(key: key) {
    controller = Get.put(UpdateOrderController(order: orderModel));
  }
  final bool isCreate;
  final OrderModel? orderModel;
  late final UpdateOrderController controller;
  final InfiniteListController infiniteListController;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
          hasBack: true,
          title: isCreate ? "Tạo mới lái xe " : "Chỉnh sửa thông tin"),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 77,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: sp12),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: greyColor),
                    borderRadius: BorderRadius.circular(sp8),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text("Hủy", style: h6),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    isCreate
                        ? await controller.createDriver()
                        : await controller.updateDriver();
                    Future.delayed(
                      const Duration(seconds: 1),
                      () {
                        infiniteListController.onRefresh();
                      },
                    );
                  }
                },
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
                          isCreate ? "Tạo mới" : "Chỉnh sửa",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: sp16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 24),
                baseContainer(Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Họ và tên ",
                              style: p5.copyWith(color: blackColor)),
                          const TextSpan(
                              text: "*", style: TextStyle(color: red_1)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    ValidateTextField(
                      initialValue: " controller.order.value.orderName",
                      hintText: "Nhập họ và tên",
                      onChanged: (p0) {},
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Bạn cần điền thông tin này';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Điện thoại ",
                              style: p5.copyWith(color: blackColor)),
                          const TextSpan(
                              text: "*", style: TextStyle(color: red_1)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    ValidateTextField(
                      initialValue: "controller.order.value.phoneNumber",
                      onChanged: (p0) {},
                      hintText: "Nhập số điện thoại",
                      textInputType: TextInputType.phone,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Bạn cần điền thông tin này';
                        } else if (!(p0.length == 9 || p0.length == 12)) {
                          return 'Vui lòng nhập đúng định dạng';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "CCCD/CMT ",
                              style: p5.copyWith(color: blackColor)),
                          const TextSpan(
                              text: "*", style: TextStyle(color: red_1)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    ValidateTextField(
                      initialValue: "controller.order.value.passport",
                      onChanged: (p0) {},
                      textInputType: TextInputType.number,
                      hintText: "Nhập số CCCD/CMT",
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Bạn cần điền thông tin này';
                        } else if (!(p0.length == 9 || p0.length == 12)) {
                          return 'Vui lòng nhập đúng định dạng';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Email",
                      style: p5,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    ValidateTextField(
                      initialValue: "controller.order.value.email",
                      onChanged: (p0) {
                        // controller.order.value.email = p0;
                      },
                      hintText: "Nhập email",
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Obx(() => SizedBox(
                          height:
                              controller.avatarLocal.value.path != "" ? 64 : 53,
                          child: Row(
                            children: [
                              if (controller.avatarLocal.value.path == "" &&
                                  !isCreate)
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: greyColor),
                                  ),
                                  child: Image.network(
                                    Api.defaultLogo,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              if (controller.avatarLocal.value.path != "")
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: greyColor),
                                  ),
                                  child: Image.file(
                                    File(controller.avatarLocal.value.path),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              if (controller.avatarLocal.value.path != "")
                                const SizedBox(
                                  width: 16,
                                ),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    final image = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (image != null) {
                                      controller.avatarLocal.value = image;
                                    }
                                  },
                                  child: DottedBorder(
                                    color: mainColor,
                                    strokeWidth: 1,
                                    child: Center(
                                        child: Text(
                                      '+ Tải ảnh lên',
                                      style: p5.copyWith(color: mainColor),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
