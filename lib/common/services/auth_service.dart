import 'dart:convert';

import 'package:get/get.dart';

import '../../data/models/user_model/user_model.dart';
import '../../data/providers/account_provider.dart';
import '../constants/constans.dart';
import '../../local storage/app_shared_preference.dart';

class AuthService extends GetxService {
  Future<AuthService> init() async => this;
  final Rx<UserModel> user = UserModel().obs;
  @override
  void onInit() {
    super.onInit();
    var token = AppSharedPreference.instance.getValue(PrefKeys.TOKEN);
    if (token != null) {
      setIsAuth(true);
      getDetailUser();
    } else {
      setIsAuth(false);
    }
  }

  Future<void> getDetailUser() async {
    final Map account =
        json.decode(AppSharedPreference.instance.getValue(PrefKeys.USER) ?? '');
    final result = await UserModelProvider().getDetailUser(account['id']);
    if (result != null) {
      user.value = result;
      user.refresh();
    }
  }

  final RxBool isAuth = false.obs;

  void setIsAuth(bool newValue) {
    isAuth.value = newValue;
  }
}
