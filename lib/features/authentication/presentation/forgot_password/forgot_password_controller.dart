import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhe_ctv/common/util/dialog_utils.dart';

import '../../application/login_service.dart';

class ForgotPasswordController extends GetxController {
  final _loginService = LoginService();
  var step = 1.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  final RxString sessionKey = ''.obs;
  final RxBool isResendOTP = false.obs;
  RxInt isOTPVerify = 3.obs;

  final RxInt countTime = 15.obs;
  Timer? _timer;
  changeStep({required int value}) {
    step.value = value;
    update();
  }

  Future<void> requestOTPForgotPassword() async {
    DialogUtils.showLoadingDialog(Get.context!);
    final result = await _loginService
        .requestOTPForgotPassword(emailController.text)
        .onError((error, stackTrace) {
      Get.back();
      return DialogUtils.showSuccessDialog(
        Get.context!,
        content: error.toString(),
        icon: 'ic_error.svg',
        accept: () => Get.back(),
      );
    });

    if (result != null) {
      Get.back();
      sessionKey.value = result;
      isResendOTP.value = true;
      startTimer();
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (countTime.value == 0) {
          _timer!.cancel();
        } else {
          countTime.value--;
        }
      },
    );
  }

  Future<void> resendOTPFogotPassword() async {
    if (countTime.value < 1) {
      countTime.value = 15;
      startTimer();
      _loginService.resendOTPFogotPassword(sessionKey.value);
    }
  }

  Future<void> otpVerify(String otp) async {
    DialogUtils.showLoadingDialog(Get.context!);
    final result = await _loginService
        .otpVerify(otp, sessionKey.value)
        .onError((error, stackTrace) {
      Get.back();
      return DialogUtils.showSuccessDialog(
        Get.context!,
        content: error.toString(),
        icon: 'ic_error.svg',
        accept: () => Get.back(),
      );
    });
    isOTPVerify.value = result ?? false ? 1 : 0;
    Future.delayed(
      const Duration(seconds: 1),
      () {
        isOTPVerify.refresh();
      },
    );
    isOTPVerify.refresh();
    if (result != null) {
      Get.back();
    }
  }
}
