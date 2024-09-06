import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/customer_model/customer_model.dart';
import '../../../data/providers/customer_provider.dart';

class UpdateCustomerController extends GetxController {
  final Rx<XFile> avatarLocal = XFile("").obs;
  final Rx<CustomerModel> customer = CustomerModel().obs;
  final _provider = CustomerModelProvider();

  UpdateCustomerController({CustomerModel? customer}) {
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
