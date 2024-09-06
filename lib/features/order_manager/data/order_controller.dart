import 'package:get/get.dart';
import 'package:lhe_ctv/common/model/select_model.dart';

import '../../../common/util/dialog_utils.dart';
import '../../../data/models/transport_model.dart';
import '../../../data/providers/customer_provider.dart';

class OrderController extends GetxController {
  final indexFilter = (-1).obs;
  final listTramsport = <TransportModel>[].obs;
  final _provider = CustomerModelProvider();
  String search = '', reason = "";
  final List listFilter = [
    'Tất cả',
    'Chờ xác nhận',
    'Đã xác nhận',
    'Hoàn thành',
  ];

  final List<SelectModel> listSelectModel = [
    SelectModel(label: "Số lượng không đủ", value: "1"),
    SelectModel(label: "Khách yêu cầu hủy", value: "2"),
    SelectModel(label: "Thay đổi địa chỉ nhận hàng", value: "3"),
    SelectModel(label: "Khác", value: "4"),
  ];

  Future<List?> fetchAllOrder(int page) async {
    var data = {
      "page": "$page",
      "page_size": "20",
      "keyword": search,
      "status": indexFilter.value == -1 ? "" : indexFilter.value.toString(),
    };

    final result = await _provider.getAllOrder(data).catchError((err) {
      return DialogUtils.showErrorDialog(Get.context!, content: err.toString());
    });
    if (result != null) {
      // return result;
    } else {
      return [];
    }
    return null;
  }

  Future<void> deleteOrder(int orderId) async {
    final result = await _provider.deleteOrder(orderId).catchError((err) {
      return DialogUtils.showErrorDialog(Get.context!, content: err.toString());
    });
    if (result == true) {
      Get.back();
      DialogUtils.showSuccessDialog(Get.context!,
          content: "Xóa thành công", accept: () => Get.back());
    }
  }

  void getOrderModels(param0) {}
}
