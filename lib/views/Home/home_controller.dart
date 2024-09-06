import 'package:get/get.dart';

class HomeController extends GetxController {
  final indexPage = 0.obs;
  final selectedDate = <String?>[null, null].obs;

  void onSelectDate(String date) {
    List<String?> listRange = date.split(' - ');
    if (listRange.length == 1) {
      listRange = [
        ...listRange,
        ...[null]
      ];
    }
    selectedDate.value = listRange;
    update();
  }
}
