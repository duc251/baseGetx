import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/constants/constans.dart';
import '../../../common/constants/assets_path.dart';
import '../../../common/util/enum/tab_item.dart';
import '../../../local storage/app_shared_preference.dart';
import '../model/app_model.dart';

class AppController extends GetxController {
  var listApp = [
    AppModel(
      logo: Image.asset(
        '${AssetsPath.image}/app_phieu.png',
        width: double.infinity,
      ),
      title: 'Phiếu giao dịch',
      routeName: TabItemCode.order,
      show: true,
    ),
    AppModel(
      logo: Image.asset(
        '${AssetsPath.image}/app_phieu.png',
        width: double.infinity,
      ),
      title: 'Phiếu kho',
      routeName: TabItemCode.report,
      show: true,
    ),
  ].obs;

  var dataFinancialSituation = [
    {
      'title': 'Tổng tiền',
      'value': '1000000',
    },
    {
      'title': 'Phải thu',
      'value': '2000000',
    },
    {
      'title': 'Phải trả',
      'value': '3000000',
    }
  ].obs;

  var distributorName = ''.obs;

  @override
  void onInit() {
    var user = jsonDecode(AppSharedPreference.instance.getValue(PrefKeys.USER));
    distributorName.value = user["fullname"];
    update();
    super.onInit();
  }
}
