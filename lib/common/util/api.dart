class Api {
  static const String KEY = 'CTV';
  static const String ENV = 'test'; //prod || test

  static const String baseURL = 'https://api.thachlonghai.co';
  // static const String baseURL = 'http://192.168.68.108:8000';
  static const String shop = '$baseURL/micro-shop-$ENV/shop/api';
  // static const String shop = 'http://192.168.68.108:8002/shop/api';

  static const String account = '$baseURL/micro-account-$ENV/account/api';
  // static const String account = 'http://192.168.68.108:8000/account/api';

  static const String product = '$baseURL/micro-product-$ENV/product/api';
  // static const String product = 'http://192.168.68.108:8004/product/api';
  // static const String login = '$baseURL/micro-account-$ENV/account/api/login';
  static const String login = '$account/login';
  static const String getAccountById = '$account/get_account_by_id';

  // static const String register = '$baseURL/micro-account-$ENV/account/api/register-otp';
  static const String register = '$account/register-otp';
  static const String resendOTP = '$account/resend-otp';
  static const String resendOTPFogotPassword =
      '$account/resent_otp_forgotpassword';

  static const String requestOTPForgotPassword = '$account/otp_check';
  static const String otpVerify = '$account/verify_otp';
  static const String resetPassword = '$account/reset_password';

  static const String registerVerify = '$account/register-otp-verify';

  static const String refresh_token =
      '$baseURL/micro-account-$ENV/account/api/refresh_token';
  static const String customer = '$baseURL/v1/api/ot/';

  static const String defaultLogo =
      "https://thachlonghai.com.vn/FileManager/Thachlonghai/Logo/logo.png";
}
