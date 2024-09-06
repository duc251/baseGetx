import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/model/select_model.dart';
import '../../../common/services/auth_service.dart';
import '../../../common/util/dialog_utils.dart';
import '../../../data/models/order_model.dart';
import '../../../data/providers/customer_provider.dart';

class UpdateProfileController extends GetxController {
  final Rx<XFile> avatarLocal = XFile("").obs;
  final Rx<OrderModel> order = OrderModel().obs;
  final _provider = CustomerModelProvider();
  String? phone, fullname;
  final List<SelectModel> listSelectModel = [
    SelectModel(label: "VietCombank", value: "1"),
    SelectModel(label: "Techcombank", value: "2"),
    SelectModel(label: "ACB", value: "3"),
    SelectModel(label: "ABC", value: "4"),
  ];
  UpdateProfileController({OrderModel? order}) {
    if (order != null) {
      this.order.value = order;
    }
  }

  Future<void> createDriver() async {
    DialogUtils.showLoadingDialog(Get.context!);
    final result = await _provider
        .createOrder(order.value, avatar: avatarLocal.value)
        .catchError((err) {
      return DialogUtils.showErrorDialog(Get.context!, content: err.toString());
    });
    Get.back();
    if (result == true) {
      Get.back();
      DialogUtils.showSuccessDialog(Get.context!,
          content: "Tạo thành công", accept: () => Get.back());
    }
  }

  Future<void> updateProfileAuths() async {
    DialogUtils.showLoadingDialog(Get.context!);
    final result = await _provider
        .updateProfileAccount(fullname: fullname, phone: phone)
        .catchError((err) {
      return DialogUtils.showErrorDialog(Get.context!, content: err.toString());
    });
    Get.back();
    if (result == true) {
      Get.back();
      final authUser = Get.find<AuthService>().user;
      authUser.value.username = phone ?? authUser.value.username;
      authUser.value.fullname = fullname ?? authUser.value.fullname;
      authUser.refresh();
      DialogUtils.showSuccessDialog(Get.context!,
          content: "Sửa thành công", accept: () => Get.back());
    }
  }
}
