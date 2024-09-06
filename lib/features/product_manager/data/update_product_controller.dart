import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lhe_ctv/data/providers/customer_provider.dart';

import '../../../data/models/product_model/product_model.dart';

class UpdateProductController extends GetxController {
  final Rx<XFile> avatarLocal = XFile("").obs;
  final Rx<ProductModel> customer = ProductModel().obs;
  final _provider = CustomerModelProvider();

  UpdateProductController({ProductModel? customer}) {
    if (customer != null) {
      this.customer.value = customer;
    }
  }

  // Future<void> updateCustomer() async {
  //   DialogUtils.showLoadingDialog(Get.context!);
  //   final result = await _provider
  //       .updateCustomer(customer.value, avatar: avatarLocal.value)
  //       .catchError((err) {
  //     return DialogUtils.showErrorDialog(Get.context!, content: err.toString());
  //   });
  //   Get.back();
  //   if (result == true) {
  //     Get.back();
  //     DialogUtils.showSuccessDialog(Get.context!,
  //         content: "Sửa thành công", accept: () => Get.back());
  //   }
  // }
}
