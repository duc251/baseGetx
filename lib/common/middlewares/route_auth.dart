// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';

// import '../routes/app_routes.dart';
// import '../services/auth_service.dart';

// class AuthMiddleWare extends GetMiddleware {
//   final authService = Get.find<AuthService>();

//   @override
//   RouteSettings? redirect(String? route) {
//     return authService.isAuth.value
//         ? null
//         : const RouteSettings(name: Routes.routeLogin);
//   }
// }
