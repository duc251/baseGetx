import 'package:get/get.dart';

import '../../../../common/services/auth_service.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(AuthService());
  }
}
