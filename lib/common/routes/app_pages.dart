import 'package:get/route_manager.dart';
import '../../views/Auth/LoginScreen.dart';
import '../../views/Home/HomeScreen.dart';
import '../middlewares/middlewares.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.routeHomeScreen;

  static final routes = [
    // HOME SCREEN
    GetPage(
      name: Routes.routeHomeScreen,
      page: () => HomeScreen(),
      middlewares: [RouteMiddleware()],
    ),

    // LOGIN SCREEN
    GetPage(
      name: Routes.routeLogin,
      page: () => const LoginScreen(),
    ),
  ];
}
