import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension IntExtension on int {
  String get formatConcurrencyToString {
    String oCcy = NumberFormat("#,##0", "en_US").format(this);
    String result = oCcy.replaceAll(',', '.');
    return result;
  }

  String get sex {
    switch (this) {
      case 1:
        return "Nam".tr;
      case 2:
        return "Nữ".tr;
      case 3:
        return "Khác".tr;
      default:
        return "";
    }
  }
}
