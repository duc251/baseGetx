import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lhe_ctv/common/constants/app_typography.dart';
import 'package:lhe_ctv/common/services/auth_service.dart';
import 'package:lhe_ctv/features/account/update_profile/update_profile.dart';

import '../../../components/item/row.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final authUser = Get.find<AuthService>().user;
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const CustomAppBar(
        hasBack: true,
        title: "Thông tin tài khoản",
        trailingIcons: [],
      ),
      bottomNavigationBar: BottomAppBar(
        child: baseContainer(
          InkWell(
            onTap: () => Get.to(() => UpdateProfile()),
            child: Container(
              height: 45,
              padding: const EdgeInsets.symmetric(vertical: sp12),
              decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(color: greyColor),
                borderRadius: BorderRadius.circular(sp8),
              ),
              child: const Center(
                child: Text("Chỉnh sửa thông tin", style: h6),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            baseContainer(Column(
              children: [
                buildRowItem(
                    title: "Mã CTV", content: authUser.value.accountCode!),
                const SizedBox(height: sp8),
                Obx(
                  () => buildRowItem(
                      title: "Họ và tên", content: authUser.value.fullname!),
                ),
                const SizedBox(height: sp8),
                Obx(
                  () => buildRowItem(
                      title: "Số điện thoại",
                      content: authUser.value.username!),
                ),
                const SizedBox(height: sp8),
                buildRowItem(title: "Email", content: authUser.value.email!),
                const SizedBox(height: sp8),
                buildRowItem(
                    title: "website",
                    content: authUser.value.collaborator!.first.domain!),
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            baseContainer(Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thêm địa chỉ để xác định địa điểm\nbán hàng và vận chuyển',
                      style: AppTypography.p7
                          .copyWith(color: const Color(0xffaaaaaa)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Thêm địa chỉ",
                      style: AppTypography.p5.copyWith(color: mainColor),
                    ),
                  ],
                ),
                SvgPicture.asset('assets/icons/map_location.svg'),
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            baseContainer(Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thêm tài khoản ngân hàng để sử dụng\nchức năng thanh toán trực tuyến',
                      style: AppTypography.p7
                          .copyWith(color: const Color(0xffaaaaaa)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Thêm tài khoản ngân hàng",
                      style: AppTypography.p5.copyWith(color: mainColor),
                    ),
                  ],
                ),
                Image.asset('assets/imgs/credit-card 1.png'),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
