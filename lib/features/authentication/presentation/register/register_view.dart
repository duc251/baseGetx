import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lhe_ctv/features/authentication/presentation/register/register_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_typography.dart';
import 'register_item.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController? username, password;
  final _loginValidate = GlobalKey<FormState>();
  final _registerValidate = GlobalKey<FormState>();
  final _registerController = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: sp16),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Obx(() => IndexedStack(
                  index: _registerController.indexStack.value,
                  children: [
                    registerStep1(context),
                    verifyOTPView(context),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 94.sp,
                        ),
                        Center(
                          child: Text(
                            'Đăng ký tài khoản'.tr,
                            style: AppTypography.h2,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 24.sp,
                        ),
                        Container(
                          height: 343,
                          color: green_2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  "assets/icons/register_sussess.svg"),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Quý khách đã đăng ký\nthành công!',
                                style:
                                    AppTypography.h5.copyWith(color: green_1),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.sp,
                        ),
                        const Spacer(),
                        MainButton(
                            event: () => Get.back(),
                            icon: null,
                            largeButton: false,
                            title: 'Về trang đăng nhập'),
                        SizedBox(height: 124.sp),
                        SizedBox(
                          height: 24.sp,
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Form verifyOTPView(BuildContext context) {
    return Form(
      key: _registerValidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 94.sp,
          ),
          Text(
            'Xác nhận OTP'.tr,
            style: AppTypography.h2,
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 24.sp,
          ),
          BaseContainer(
              context,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _registerController.email.text,
                    style: AppTypography.p6,
                  ),
                  Obx(() => InkWell(
                        onTap: () => _registerController.handleResendOTP(),
                        child: Text(
                          _registerController.countTime.value < 1
                              ? 'Gửi lại OTP'
                              : '00:${_registerController.countTime.value}s',
                          style: AppTypography.p6.copyWith(color: mainColor),
                        ),
                      )),
                ],
              ),
              color: borderColor_1,
              padding: 12),
          SizedBox(
            height: 16.sp,
          ),
          Obx(() => PinCodeTextField(
                appContext: context,
                length: 6,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  borderWidth: 1,
                  fieldHeight: 45,
                  fieldWidth: 45,
                  inactiveColor: _registerController.isOTPVerify.value == 0
                      ? AppColors.red_1
                      : AppColors.borderColor_2,
                  activeColor: _registerController.isOTPVerify.value == 0
                      ? AppColors.red_1
                      : AppColors.borderColor_2,
                ),
                errorTextSpace: 26,
                errorTextMargin: const EdgeInsets.only(left: 12),
                textStyle: AppTypography.h6,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bạn cần hoàn thiện trường này';
                  } else if (value.length < 6) {
                    return 'Bạn cần nhập đủ 6 số mã code';
                  } else if (_registerController.isOTPVerify.value == 0) {
                    return 'Mã OTP không đúng hoặc đã hết hạn';
                  }
                  return null;
                },
                onCompleted: (value) {
                  _registerController.otpKey = value;
                  _registerController.handleRegisterVerifyOTP();
                },
                onChanged: (String value) {},
              )),
          const Spacer(),
          buildRegisterOTPButton(context, _registerValidate),
          SizedBox(height: 124.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Đã có tài khoản?",
                style: AppTypography.p5,
              ),
              InkWell(
                onTap: () => Get.back(),
                child: Text(
                  " Trở lại đăng nhập",
                  style: AppTypography.p5.copyWith(color: mainColor),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24.sp,
          ),
        ],
      ),
    );
  }

  SingleChildScrollView registerStep1(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40.sp,
          ),
          Text(
            'Đăng ký'.tr,
            style: AppTypography.h2,
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 24.sp,
          ),
          buildFormRegister(context, _loginValidate,
              _registerController.username, _registerController.password),
          SizedBox(
            height: 38.sp,
          ),
          buildRegisterButton(context, _loginValidate),
          SizedBox(
            height: 14.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Đã có tài khoản?",
                style: AppTypography.p5,
              ),
              InkWell(
                onTap: () => Get.back(),
                child: Text(
                  " Trở lại đăng nhập",
                  style: AppTypography.p5.copyWith(color: mainColor),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24.sp,
          ),
        ],
      ),
    );
  }
}
