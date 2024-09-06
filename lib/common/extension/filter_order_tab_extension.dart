import 'package:get/get.dart';

enum FilterTab { all, PENDING, INPROGRESS, DONE, FAILED }

extension FilterTabExtension on FilterTab {
  String get title {
    switch (this) {
      case FilterTab.all:
        return "Tất cả".tr;
      case FilterTab.PENDING:
        return "Chờ phê duyệt".tr;
      case FilterTab.INPROGRESS:
        return "Đang xử lý".tr;
      case FilterTab.DONE:
        return "thành công".tr;
      case FilterTab.FAILED:
        return "thất bại".tr;
    }
  }
}
