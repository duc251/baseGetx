import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'common/routes/app_pages.dart';
import 'common/routes/app_routes.dart';
import 'common/services/auth_service.dart';
import 'common/constants/app_colors.dart';
import 'common/constants/app_typography.dart';
import 'common/constants/constans.dart';
import 'features/authentication/presentation/login/login_binding.dart';
import 'local storage/app_shared_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreference.instance.initSharedPreferences();
  await Get.putAsync(() => AuthService().init());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final authService = Get.find<AuthService>();

  get getToken {
    final dynamic token = AppSharedPreference.instance.getValue(PrefKeys.TOKEN);
    return token;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // translations: LocaleString(),
        // locale: LocaleString.locale,
        // locale: LocaleString.locale,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.whiteColor,
          fontFamily: 'Helvetica',
          primaryColor: const Color.fromRGBO(0, 174, 239, 1),
          buttonTheme: const ButtonThemeData(
            buttonColor: AppColors.mainColor,
          ),
          textTheme: const TextTheme(bodyMedium: TextStyle(color: blackColor)),
          appBarTheme: AppBarTheme(
            elevation: 2,
            backgroundColor: AppColors.whiteColor,
            iconTheme: const IconThemeData(
              color: AppColors.blackColor,
            ),
            titleTextStyle: AppTypography.h4.copyWith(
              color: AppColors.blackColor,
            ),
          ),
        ),

        initialBinding: LoginBinding(),
        // home: authService.isAuth.value ? HomeScreen() : LoginScreen(),
        initialRoute: Routes.routeHomeScreen,
        getPages: AppPages.routes,
        onGenerateRoute: (RouteSettings settings) {
          if (!authService.isAuth.value) {
            return Get.offNamed(Routes.routeLogin) as Route;
          }
          return settings.name as Route;
        },
      ),
    );
  }
}
