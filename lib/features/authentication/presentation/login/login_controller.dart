import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../application/login_service.dart';

class LoginController extends GetxController {
  final _loginService = LoginService();
  var rememberPassword = false.obs;
  var showPassword = false.obs;

  var username = TextEditingController();
  var password = TextEditingController();

  changeRememberPassword({required RxBool value}) {
    rememberPassword = value;
    update();
  }

  changeShowPassword({required RxBool value}) {
    showPassword = value;
    update();
  }

  Future<void> handleLogin() async {
    await _loginService.handleLogin(username.text, password.text);
  }
}
