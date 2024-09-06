import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../../common/routes/app_routes.dart';
import '../../../common/services/auth_service.dart';
import '../../../common/util/base_dio.dart';
import '../../../local storage/app_shared_preference.dart';
import '../../../common/constants/constans.dart';
import '../../../common/util/api.dart';

class LoginService {
  Future<void> handleLogin(String username, String password) async {
    try {
      var dio = BaseDio().dio();
      var res = await dio.post(Api.login, data: {
        'username': username,
        'password': password,
        'system_key': Api.KEY,
      });
      if (res.statusCode == 200) {
        AppSharedPreference.instance
            .setValue(PrefKeys.TOKEN, res.data['data']['access_token']);
        AppSharedPreference.instance.setValue(
            PrefKeys.TOKEN_REFRESH, res.data['data']['refresh_token']);
        AppSharedPreference.instance
            .setValue(PrefKeys.USER, json.encode(res.data['data']['user']));
        AppSharedPreference.instance.setValue(
            PrefKeys.PROFILE, json.encode(res.data['data']['profile']));
        // var customer_id = await
        var auth = Get.find<AuthService>();
        auth.setIsAuth(true);
        Get.offAllNamed(Routes.routeHomeScreen);
        Get.find<AuthService>().getDetailUser();
      }
    } catch (err) {
      if (err is DioError) {
        throw err.response!.data[0];
      }
      print('--------$err');
    }
  }

  Future<String?> handleRegister(String username, String password, String email,
      String fullname, String shopName, String domain) async {
    try {
      var dio = DioSingleton.getInstance().dio;
      dio.options.headers.clear();
      var res = await dio.post(Api.register, data: {
        'username': username,
        'password': password,
        'email': email,
        'fullname': fullname,
        'shop_name': shopName,
        'domain': domain,
        'system_key': Api.KEY,
      });
      return (res.data['data']['session_key']);
    } catch (err) {
      if (err is DioError) {
        throw err.response!.data['message'];
      }
      print('--------$err');
    }
    return null;
  }

  Future<bool?> handleResendOTP() async {
    try {
      var dio = DioSingleton.getInstance().dio;
      dio.options.headers.clear();
      var res = await dio.get(Api.resendOTP);
      return (res.statusCode == 200);
    } catch (err) {
      if (err is DioError) {
        throw err.response!.data.toString();
      }
    }
    return null;
  }

  Future<bool?> resendOTPFogotPassword(String sessionKey) async {
    try {
      var dio = DioSingleton.getInstance().dio;
      dio.options.headers.clear();
      var res = await dio
          .post(Api.resendOTPFogotPassword, data: {'session_key': sessionKey});
      return (res.data['code'] == 200);
    } catch (err) {
      if (err is DioError) {
        throw err.response!.data.toString();
      }
    }
    return null;
  }

  Future<String?> requestOTPForgotPassword(String email) async {
    try {
      var dio = DioSingleton.getInstance().dio;
      dio.options.headers.clear();
      var res =
          await dio.post(Api.requestOTPForgotPassword, data: {'email': email});
      return (res.data['data']['session_key']);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 400) {
          throw e.response!.data['message'];
        }
        throw e.message;
      }
    } catch (err) {
      if (err is DioError) {
        throw err.response!.data.toString();
      }
    }
    return null;
  }

  Future<bool?> otpVerify(String otp, String sessionKey) async {
    try {
      var dio = DioSingleton.getInstance().dio;
      dio.options.headers.clear();
      var res = await dio
          .post(Api.otpVerify, data: {'otp': otp, 'session_key': sessionKey});
      return (res.data['code'] == 200);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 400) {
          throw e.response!.data['message'];
        }
        throw e.message;
      }
    } catch (err) {
      if (err is DioError) {
        throw err.response!.data.toString();
      }
    }
    return false;
  }

  Future<bool?> resetPassword(String newPassword, String sessionKey) async {
    try {
      var dio = DioSingleton.getInstance().dio;
      dio.options.headers.clear();
      var res = await dio.post(Api.resetPassword,
          data: {'new_password': newPassword, 'session_key': sessionKey});
      return (res.data['code'] == 200);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 400) {
          throw e.response!.data['message'];
        }
        throw e.message;
      }
    } catch (err) {
      if (err is DioError) {
        throw err.response!.data.toString();
      }
    }
    return false;
  }

  Future<bool?> handleRegisterVerifyOTP(String otp, String sessionKey) async {
    try {
      var dio = DioSingleton.getInstance().dio;
      dio.options.headers.clear();
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['Cookie'] = 'sessionid=$sessionKey';
      var res = await dio.post(Api.registerVerify, data: {
        'otp': otp,
        'session_key': sessionKey,
      });
      return (res.statusCode == 200);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 400) {
          throw e.response!.data['message'];
        }
        throw e.message;
      }
    } catch (err) {
      if (err is DioError) {
        throw err.response!.data.toString();
      }
    }
    return false;
  }
}
