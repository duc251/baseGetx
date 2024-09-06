import 'package:get/get.dart';

import '../../../common/util/dialog_utils.dart';
import '../../../data/models/customer_model/customer_model.dart';
import '../../../data/models/transport_model.dart';
import '../../../data/providers/customer_provider.dart';

class CustomerController extends GetxController {
  final indexFilter = (-1).obs;
  final listTramsport = <TransportModel>[].obs;
  final _provider = CustomerModelProvider();
  String search = "";
  final List listFilter = [
    'Tất cả',
    'Khả dụng',
    'Chờ vận chuyển',
    'Đang vận chuyển',
  ];

  Future<List<CustomerModel>> fetchAllCustomer(int page) async {
    var data = {
      "page": "$page",
      "page_size": "20",
      "keyword": search,
    };

    final result = await _provider.getAllCustomer(data).catchError((err) {
      return DialogUtils.showErrorDialog(Get.context!, content: err.toString());
    });
    if (result != null) {
      return result;
    } else {
      return [];
    }
  }

  Future<void> deleteCustomer(
      int customerId, dynamic infiniteListController) async {
    await DialogUtils.showErrorDialog(
      Get.context!,
      content: "Xác nhận xóa khách hàng này?",
      accept: () {
        _provider
            .deactiveCustomer(customerId)
            .then((value) => infiniteListController.onRefresh());
        Get.back();
      },
    );
  }
}
