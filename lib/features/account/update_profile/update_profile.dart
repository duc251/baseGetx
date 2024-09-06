import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lhe_ctv/common/constants/app_typography.dart';
import 'package:lhe_ctv/common/widgets/base_textfield.dart';
import 'package:lhe_ctv/components/item/row.dart';
import 'package:lhe_ctv/features/account/update_profile/update_profile_controller.dart';

import '../../../common/services/auth_service.dart';
import '../../../common/widgets/base_drop_down_box.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({super.key});
  final authUser = Get.find<AuthService>().user.value;

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  final CameraPosition _kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  final controller = Get.put(UpdateProfileController());
  final _keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 77,
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () {
            if (_keyForm.currentState?.validate() ?? false) {
              controller.updateProfileAuths();
            }
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: sp12),
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(sp8),
            ),
            child: Text(
              "Xác nhận",
              style: h6.copyWith(
                color: whiteColor,
              ),
            ),
          ),
        ),
      ),
      appBar: const CustomAppBar(
          hasBack: true, title: "Thông tin tài khoản", trailingIcons: []),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(
              height: 8,
            ),
            baseContainer(
              Form(
                key: _keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildRowText(
                        title: "Mã CTV", content: authUser.accountCode ?? ""),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Họ và tên ",
                              style: p6.copyWith(color: blackColor)),
                          const TextSpan(
                              text: "*", style: TextStyle(color: red_1)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    ValidateTextField(
                      initialValue: authUser.fullname ?? "",
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Bạn cần hoàn thành trường thông tin này';
                        }
                        return null;
                      },
                      onChanged: (p0) => controller.fullname = p0,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Số điện thoại ",
                              style: p6.copyWith(color: blackColor)),
                          const TextSpan(
                              text: "*", style: TextStyle(color: red_1)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    ValidateTextField(
                      textInputType: TextInputType.phone,
                      initialValue: authUser.username ?? "",
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Bạn cần hoàn thành trường thông tin này';
                        }
                        return null;
                      },
                      onChanged: (p0) => controller.phone = p0,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    buildRowText(
                        title: "Website",
                        content: authUser.collaborator!.first.domain ?? ""),
                  ],
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
                    Expanded(
                        child: GoogleMap(initialCameraPosition: _kGooglePlex)),
                    Text(
                      "Nhấn vào MAP để chọn vị trí",
                      style: AppTypography.p7
                          .copyWith(color: const Color(0xffaaaaaa)),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/location.svg'),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "  32 mễ trì hạ, mễ trì, cầu giấy, hà nội",
                          style: AppTypography.p5.copyWith(color: mainColor),
                        )
                      ],
                    ),
                  ],
                ),
                height: 240),
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
                        "Thêm tài khoản ngân hàng để sử dụng\nchức năng thanh toán trực tuyến",
                        style: AppTypography.p7
                            .copyWith(color: const Color(0xffaaaaaa)),
                      ),
                      Image.asset('assets/imgs/credit-card 1.png'),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Ngân hàng ",
                            style: p6.copyWith(color: blackColor)),
                        const TextSpan(
                            text: "*", style: TextStyle(color: red_1)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  BaseDropDownBox(
                    hintText: "Lựa chọn ngân hàng",
                    listItems: controller.listSelectModel,
                    label: controller.listSelectModel.first.subTitle,
                    selectedItem: (item) {},
                    isOverlayOpened: (value) {},
                    onClear: () {},
                    validator: (value) {
                      if ((value?.isEmpty ?? false)) {
                        return "Bạn cần điền thông tin này".tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Số tài khoản ",
                            style: p6.copyWith(color: blackColor)),
                        const TextSpan(
                            text: "*", style: TextStyle(color: red_1)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  ValidateTextField(
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'Bạn cần hoàn thành trường thông tin này';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Tên chủ tài khoản ",
                            style: p6.copyWith(color: blackColor)),
                        const TextSpan(
                            text: "*", style: TextStyle(color: red_1)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  ValidateTextField(
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'Bạn cần hoàn thành trường thông tin này';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
