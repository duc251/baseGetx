import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../application/login_service.dart';

class RegisterController extends GetxController {
  final _loginService = LoginService();
  var rememberPassword = false.obs;
  var showPassword = false.obs;
  final indexStack = 0.obs;
  var username = TextEditingController();
  var password = TextEditingController();
  final RxInt countTime = 15.obs;
  final RxInt isOTPVerify = 3.obs;
  Timer? _timer;
  final email = TextEditingController();
  final fullname = TextEditingController();
  final domain = TextEditingController();
  final shopName = TextEditingController();

  late final String _sesionKey;
  String? otpKey;
  changeRememberPassword({required RxBool value}) {
    rememberPassword = value;
    update();
  }

  changeShowPassword({required RxBool value}) {
    showPassword = value;
    update();
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

  Future<void> handleResendOTP() async {
    if (countTime.value < 1) {
      countTime.value = 15;
      startTimer();
      _loginService.handleResendOTP();
    }
  }

  Future<void> handleRegister() async {
    final result = await _loginService.handleRegister(username.text,
        password.text, email.text, fullname.text, shopName.text, domain.text);
    if (result != null) {
      indexStack.value = 1;
      _sesionKey = result;
      startTimer();
    }
    Get.back();
  }

  Future<void> handleRegisterVerifyOTP() async {
    final result = await _loginService
        .handleRegisterVerifyOTP(otpKey!, _sesionKey)
        .onError((error, stackTrace) {
      isOTPVerify.value = 0;
      return null;
    });
    if (result == true) {
      isOTPVerify.value = 1;
      isOTPVerify.refresh();
    } else {
      isOTPVerify.value = 0;
    }
  }
}
