import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/base/base_button.dart';
import '../../../../common/base/base_input.dart';
import '../../../../common/util/dialog_utils.dart';
import '../../../../common/util/enum/status_noti.dart';
import '../../../../components/notification/index.dart';
import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_spacing.dart';
import '../../../../common/constants/app_typography.dart';
import '../../../../common/util/event.dart';
import 'register_controller.dart';

Widget buildFormRegister(
  BuildContext context,
  GlobalKey key,
  TextEditingController username,
  TextEditingController password,
) {
  return Form(
    key: key,
    child: Column(
      children: [
        AppInput(
          label: 'Số điện thoại'.tr,
          hintText: 'Nhập số điện thoại'.tr,
          controller: username,
          context: context,
          show: true,
          required: true,
          isPassword: false,
          textInputType: TextInputType.phone,
          suffixIcon: null,
          validate: (String value) {
            if (value.isEmpty || value.length < 9) {
              return 'Bạn cần hoàn thiện trường thông tin này';
            }
          },
          maxLines: 1,
        ),
        const SizedBox(height: 16),
        GetBuilder<RegisterController>(builder: (controller) {
          return AppInput(
            label: 'Mật khẩu'.tr,
            hintText: 'Nhập mật khẩu'.tr,
            controller: password,
            context: context,
            show: controller.showPassword.value,
            required: true,
            isPassword: true,
            textInputType: TextInputType.text,
            suffixIcon: IconButton(
              icon: Icon(
                controller.showPassword.value
                    ? Icons.visibility
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () {
                controller.changeShowPassword(
                    value:
                        controller.showPassword.value ? false.obs : true.obs);
              },
            ),
            validate: (String value) {
              if (value.isEmpty || value.length < 8) {
                return 'Bạn cần hoàn thiện trường thông tin này';
              } else if (!isValidPassword(value)) {
                return 'Password cần có kí tự đặc biệt, chữ hoa và chữ thường';
              }
            },
            maxLines: 1,
          );
        }),
        const SizedBox(height: 16),
        GetBuilder<RegisterController>(builder: (controller) {
          return AppInput(
            label: 'Họ và tên'.tr,
            hintText: 'Nhập họ và tên'.tr,
            controller: controller.fullname,
            required: true,
            context: context,
            isPassword: false,
            textInputType: TextInputType.text,
            suffixIcon: null,
            validate: (String value) {
              if (value.isEmpty || value.length < 5) {
                return 'Bạn cần hoàn thiện trường thông tin này';
              }
            },
            maxLines: 1,
          );
        }),
        const SizedBox(height: 16),
        GetBuilder<RegisterController>(builder: (controller) {
          return AppInput(
            label: 'Email'.tr,
            hintText: 'Nhập email'.tr,
            controller: controller.email,
            context: context,
            suffixIcon: null,
            required: true,
            isPassword: false,
            textInputType: TextInputType.emailAddress,
            validate: (String value) {
              if (value.isEmpty) {
                return 'Bạn cần nhập đúng định dạng email';
              } else if (!isValidEmail(value)) {
                return 'Bạn cần điền đúng định dạng email';
              }
            },
            maxLines: 1,
          );
        }),
        const SizedBox(height: 16),
        GetBuilder<RegisterController>(builder: (controller) {
          return AppInput(
            label: 'Tên cửa hàng'.tr,
            hintText: 'Tên cửa hàng'.tr,
            controller: controller.shopName,
            context: context,
            textInputType: TextInputType.text,
            suffixIcon: null,
            required: true,
            isPassword: false,
            validate: (String value) {
              if (value.isEmpty) {
                return 'Bạn cần hoàn thiện trường thông tin này';
              }
            },
            maxLines: 1,
          );
        }),
        const SizedBox(height: 16),
        GetBuilder<RegisterController>(builder: (controller) {
          return AppInput(
            label: 'Tên miền'.tr,
            hintText: 'Nhập tên miền',
            controller: controller.domain,
            context: context,
            suffixIcon: IntrinsicWidth(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  ".thachlonghai.co  ",
                  style: AppTypography.p5,
                ),
              ),
            ),
            isPassword: false,
            required: true,
            textInputType: TextInputType.text,
            validate: (String value) {
              if (value.isEmpty) {
                return 'Bạn cần hoàn thiện trường thông tin này';
              }
            },
            maxLines: 1,
          );
        }),
      ],
    ),
  );
}

Widget buildRegisterButton(BuildContext context, GlobalKey<FormState> key) {
  final registerController = Get.find<RegisterController>();
  return StatefulBuilder(
    builder: (context, setState) => SizedBox(
      width: double.infinity,
      child: MainButton(
        title: 'Đăng ký'.tr,
        event: () {
          if (checkValidate(key)) {
            showDialog(
              context: context,
              builder: (context) => Center(
                child: PopNotification(
                    context, 'Vui lòng đợi', () {}, StatusChat.LOADING),
              ),
            );
            registerController.handleRegister().onError((error, stackTrace) => {
                  Get.back(),
                  DialogUtils.showSuccessDialog(
                    icon: "ic_error.svg",
                    context,
                    content: "Đăng ký thất bại\n $error".tr,
                    accept: () {
                      Get.back();
                    },
                  ),
                });
          }
        },
        largeButton: true,
        icon: null,
      ),
    ),
  );
}

Widget buildRegisterOTPButton(BuildContext context, GlobalKey<FormState> key) {
  final registerController = Get.find<RegisterController>();
  return StatefulBuilder(
    builder: (context, setState) => SizedBox(
      width: double.infinity,
      child: Obx(() => MainButton(
            title: 'Tiếp tục'.tr,
            isEnable: registerController.isOTPVerify.value == 1,
            event: () {
              registerController.indexStack.value = 2;
            },
            largeButton: true,
            icon: null,
          )),
    ),
  );
}

Widget buildMoreActionLogin() {
  final registerController = Get.put(RegisterController());
  return SizedBox(
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: GetBuilder<RegisterController>(
                builder: (controller) {
                  return Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    value: registerController.rememberPassword.value,
                    onChanged: (value) {
                      if (value != null) {
                        registerController.changeRememberPassword(
                          value: value ? true.obs : false.obs,
                        );
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Nhớ tài khoản'.tr,
              style: AppTypography.p4.copyWith(color: AppColors.greyColor),
            ),
          ],
        ),
        SizedBox(
          height: 24,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(sp0),
            ),
            onPressed: () {
              Get.toNamed('/forgot_password');
            },
            child: Text(
              'Quên mật khẩu'.tr,
              style: AppTypography.p4.copyWith(color: AppColors.greyColor),
            ),
          ),
        ),
      ],
    ),
  );
}
