import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/util/dialog_utils.dart';
import '../../../data/models/order_model.dart';
import '../../../data/providers/customer_provider.dart';

class UpdateOrderController extends GetxController {
  final Rx<XFile> avatarLocal = XFile("").obs;
  final Rx<OrderModel> order = OrderModel().obs;
  final _provider = CustomerModelProvider();

  UpdateOrderController({OrderModel? order}) {
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

  Future<void> updateDriver() async {
    DialogUtils.showLoadingDialog(Get.context!);
    final result = await _provider
        .updateOrder(order.value, avatar: avatarLocal.value)
        .catchError((err) {
      return DialogUtils.showErrorDialog(Get.context!, content: err.toString());
    });
    Get.back();
    if (result == true) {
      Get.back();
      DialogUtils.showSuccessDialog(Get.context!,
          content: "Sửa thành công", accept: () => Get.back());
    }
  }
}
