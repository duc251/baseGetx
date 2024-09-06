import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lhe_ctv/features/authentication/presentation/register/register_view.dart';
import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_typography.dart';
import 'login_controller.dart';
import 'login_item.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController? username, password;

  final _loginValidate = GlobalKey<FormState>();
  final _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: sp16),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Center(
                    child: Image.asset(
                  '${AssetsPath.image}/lh_logo.png',
                  width: 82.sp,
                  height: 88.sp,
                )),
                SizedBox(
                  height: 48.sp,
                ),
                Text(
                  'Đăng nhập'.tr,
                  style: AppTypography.h2,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 24.sp,
                ),
                buildFormLogin(context, _loginValidate,
                    _loginController.username, _loginController.password),
                SizedBox(
                  height: 16.sp,
                ),
                buildMoreActionLogin(),
                SizedBox(
                  height: 38.sp,
                ),
                buildLoginButton(context, _loginValidate),
                SizedBox(height: 124.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bạn chưa có tài khoản?",
                      style: AppTypography.p5,
                    ),
                    InkWell(
                      onTap: () => Get.to(() => const RegisterView()),
                      child: Text(
                        " Đăng ký ngay",
                        style: AppTypography.p5.copyWith(color: mainColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
