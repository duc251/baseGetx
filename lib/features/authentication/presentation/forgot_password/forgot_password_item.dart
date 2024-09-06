import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../common/base/base_button.dart';
import '../../../../common/base/base_input.dart';
import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_spacing.dart';
import '../../../../common/constants/app_typography.dart';
import '../../../../common/util/event.dart';
import 'forgot_password_controller.dart';

Widget buildStepCircle(int index, String title, bool active) {
  final forgotPasswordController = Get.put(ForgotPasswordController());
  return SizedBox(
    width: 100,
    child: Column(
      children: [
        Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(sp0),
          decoration: BoxDecoration(
              border: Border.all(
                width: active ? 0 : 1,
                color: !active ? AppColors.borderColor_2 : AppColors.whiteColor,
              ),
              borderRadius: BorderRadius.circular(50)),
          child: CircleAvatar(
            backgroundColor:
                active ? AppColors.mainColor : AppColors.whiteColor,
            child: Center(
                child: Text(
              '$index',
              style: active
                  ? AppTypography.h6.copyWith(color: AppColors.whiteColor)
                  : AppTypography.p6.copyWith(color: AppColors.greyColor),
            )),
          ),
        ),
        const SizedBox(height: sp16),
        SizedBox(
          width: 85,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: active
                ? AppTypography.h6.copyWith(color: AppColors.mainColor)
                : AppTypography.p6.copyWith(color: AppColors.greyColor),
          ),
        ),
      ],
    ),
  );
}

Widget buildStep1(
  BuildContext context,
  GlobalKey<FormState> keyForm,
) {
  final forgotPasswordController = Get.put(ForgotPasswordController());
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      SizedBox(
        height: 320,
        child: Form(
          key: keyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppInput(
                  label: 'Email',
                  hintText: 'Nhập email',
                  controller: forgotPasswordController.emailController,
                  context: context,
                  show: true,
                  isPassword: false,
                  textInputType: TextInputType.emailAddress,
                  suffixIcon: Obx(() => TextButton(
                        onPressed: () {
                          forgotPasswordController.isResendOTP.value
                              ? forgotPasswordController
                                  .resendOTPFogotPassword()
                              : forgotPasswordController
                                  .requestOTPForgotPassword();
                        },
                        child: Text(
                          forgotPasswordController.isResendOTP.value
                              ? forgotPasswordController.countTime.value < 1
                                  ? 'Gửi lại OTP'
                                  : '00:${forgotPasswordController.countTime.value} s'
                              : 'Gửi OTP',
                          style: AppTypography.h6
                              .copyWith(color: AppColors.blue_1),
                        ),
                      )),
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Bạn cần hoàn thiện trường thông tin này';
                    } else if (!isValidEmail(value)) {
                      return 'Bạn cần điền đúng định dạng email';
                    }
                  }),
              const SizedBox(height: sp16),
              Text(
                'OTP'.tr,
                style: AppTypography.p5,
              ),
              const SizedBox(height: sp16),
              Obx(() => PinCodeTextField(
                    // enabled: forgotPasswordController.sessionKey.value != '' ||
                    //     forgotPasswordController.isOTPVerify.value < 2,
                    appContext: context,
                    length: 6,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      borderWidth: 1,
                      fieldHeight: 45,
                      fieldWidth: 45,
                      inactiveColor:
                          forgotPasswordController.isOTPVerify.value < 2
                              ? AppColors.red_1
                              : AppColors.borderColor_2,
                      activeColor:
                          forgotPasswordController.isOTPVerify.value < 2
                              ? AppColors.red_1
                              : AppColors.borderColor_2,
                    ),
                    errorTextSpace: 26,
                    textStyle: AppTypography.h6,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Bạn cần hoàn thiện trường này';
                      } else if (value.length < 6) {
                        return 'Bạn cần nhập đủ 6 số mã code';
                      } else if (forgotPasswordController.isOTPVerify.value <
                          2) {
                        return 'Mã OTP không đúng hoặc đã hết hạn';
                      }
                      return null;
                    },
                    onChanged: (value) {},
                    onCompleted: (value) {
                      forgotPasswordController.otpVerify(value);
                    },
                  ))
            ],
          ),
        ),
      ),
      Obx(() => MainButton(
            title: 'Xác nhận',
            event: () {
              forgotPasswordController.changeStep(value: 2);
            },
            isEnable: forgotPasswordController.isOTPVerify.value == 1,
            largeButton: true,
            icon: null,
          ))
    ],
  );
}

Widget buildStep2(
  BuildContext context,
  GlobalKey<FormState> keyForm,
) {
  final forgotPasswordController = Get.find<ForgotPasswordController>();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      SizedBox(
        height: 320,
        child: Form(
          key: keyForm,
          child: Column(
            children: [
              AppInput(
                label: 'Mật khẩu mới',
                hintText: "Nhập mật khẩu mới",
                controller: forgotPasswordController.passwordController,
                context: context,
                show: false,
                textInputType: TextInputType.emailAddress,
                validate: (String value) {
                  if (value.isEmpty) {
                    return 'Bạn cần hoàn thiện trường thông tin này';
                  } else if (forgotPasswordController
                          .rePasswordController.text !=
                      forgotPasswordController.passwordController.text) {
                    return 'Mật khẩu không giống nhau';
                  }
                },
              ),
              const SizedBox(height: sp16),
              AppInput(
                label: 'Xác nhận mật khẩu mới',
                hintText: 'Nhập mật khẩu mới',
                controller: forgotPasswordController.rePasswordController,
                context: context,
                show: false,
                maxLines: 1,
                textInputType: TextInputType.emailAddress,
                validate: (String value) {
                  if (value.isEmpty) {
                    return 'Bạn cần hoàn thiện trường thông tin này';
                  } else if (forgotPasswordController
                          .rePasswordController.text !=
                      forgotPasswordController.passwordController.text) {
                    return 'Mật khẩu không giống nhau';
                  }
                },
              ),
            ],
          ),
        ),
      ),
      MainButton(
          title: 'Tạo mật khẩu mới',
          event: () {
            if (checkValidate(keyForm)) {
              forgotPasswordController.changeStep(value: 3);
            }
          },
          largeButton: true,
          icon: null)
    ],
  );
}

Widget buildStep3(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Container(
        height: 280,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.green_2,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/register_sussess.svg"),
              const SizedBox(height: sp16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Quý khách đã tạo \n mật khẩu mới thành công!',
                  textAlign: TextAlign.center,
                  style: AppTypography.h5.copyWith(color: AppColors.green_1),
                ),
              )
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 24,
      ),
      MainButton(
          title: 'Về trang đăng nhập',
          event: () {
            Get.back();
          },
          largeButton: true,
          icon: null)
    ],
  );
}
