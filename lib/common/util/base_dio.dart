import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get/get.dart';
import '../constants/constans.dart';
import '../../local storage/app_shared_preference.dart';
import '../services/auth_service.dart';
import 'api.dart';
import 'dio_logger.dart';

class BaseDio {
  // khởi tạo biến
  Dio? _instance;
  final cookieJar = CookieJar();
  //method for getting dio instance
  Dio dio() {
    _instance ??= createDioInstance();
    return _instance!;
  }

  Dio createDioInstance() {
    var dio = Dio(
      BaseOptions(
        headers: {
          "authorization":
              "Bearer ${AppSharedPreference.instance.getValue(PrefKeys.TOKEN)}",
          "content-Type": "application/json",
          "accept": "application/json",
        },
      ),
    );
    dio.interceptors.clear();
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // print(AppSharedPreference.instance.getValue(PrefKeys.TOKEN));
          // print(AppSharedPreference.instance.getValue(PrefKeys.TOKEN_REFRESH));
          return handler.next(options);
        },
        onResponse: (response, handler) {
          //on success it is getting called here
          return handler.next(response);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401 ||
              error.response?.statusCode == 403) {
            final accessToken = await _getNewToken();

            // Cập nhật token trong bộ nhớ đệm
            _saveTokenToStorage(accessToken);

            // Thử lại yêu cầu gốc
            RequestOptions requestOptions = error.requestOptions;
            final opts = Options(method: requestOptions.method);
            dio.options.headers["Authorization"] = "Bearer $accessToken";
            dio.options.headers["Accept"] = "*/*";
            final response = await dio.request(
              requestOptions.path,
              options: opts,
              cancelToken: requestOptions.cancelToken,
              onReceiveProgress: requestOptions.onReceiveProgress,
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters,
            );
            handler.resolve(response);
          } else {
            handler.next(error);
          }
        },
      ),
      PrettyDioLogger(requestBody: true),
    ]);
    dio.interceptors.add(CookieManager(cookieJar));
    return dio;
  }

  Future<String> _getNewToken() async {
    try {
      final payload = {
        "refresh":
            "${AppSharedPreference.instance.getValue(PrefKeys.TOKEN_REFRESH)}"
      };
      var res = await Dio(BaseOptions(headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
      })).post(Api.refresh_token, data: payload);
      return res.data['access'];
    } catch (e) {
      AppSharedPreference.instance.remove(PrefKeys.TOKEN);
      Get.find<AuthService>().isAuth.value = false;
      throw Exception('err : $e');
    }
  }

  _saveTokenToStorage(String token) {
    AppSharedPreference.instance.setValue(PrefKeys.TOKEN, token);
  }

// var dio = Dio(
//   BaseOptions(
//     headers: {
//       "authorization":
//           "Bearer ${AppSharedPreference.instance.getValue(PrefKeys.TOKEN)}",
//       "content-Type": "application/json",
//       "accept": "application/json",
//     },
//   ),
// );
}

class DioSingleton {
  static DioSingleton? _instance;
  late Dio dio;
  final _cookieJar = CookieJar();
  DioSingleton._() {
    dio = Dio(
      BaseOptions(
        headers: {
          "authorization":
              "Bearer ${AppSharedPreference.instance.getValue(PrefKeys.TOKEN)}",
          "content-Type": "application/json",
          "accept": "application/json",
        },
      ),
    );
    dio.interceptors.clear();
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // print(AppSharedPreference.instance.getValue(PrefKeys.TOKEN));
          // print(AppSharedPreference.instance.getValue(PrefKeys.TOKEN_REFRESH));
          return handler.next(options);
        },
        onResponse: (response, handler) {
          //on success it is getting called here
          return handler.next(response);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401 ||
              error.response?.statusCode == 403) {
            final accessToken = await _getNewToken();

            // Cập nhật token trong bộ nhớ đệm
            _saveTokenToStorage(accessToken);

            // Thử lại yêu cầu gốc
            RequestOptions requestOptions = error.requestOptions;
            final opts = Options(method: requestOptions.method);
            dio.options.headers["Authorization"] = "Bearer $accessToken";
            dio.options.headers["Accept"] = "*/*";
            final response = await dio.request(
              requestOptions.path,
              options: opts,
              cancelToken: requestOptions.cancelToken,
              onReceiveProgress: requestOptions.onReceiveProgress,
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters,
            );
            handler.resolve(response);
          } else {
            handler.next(error);
          }
        },
      ),
      PrettyDioLogger(requestBody: true),
    ]);
    dio.interceptors.add(CookieManager(_cookieJar));
  }

  static DioSingleton getInstance() {
    _instance ??= DioSingleton._();
    return _instance!;
  }

  Future<String> _getNewToken() async {
    try {
      final payload = {
        "refresh":
            "${AppSharedPreference.instance.getValue(PrefKeys.TOKEN_REFRESH)}"
      };
      var res = await Dio(BaseOptions(headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
      })).post(Api.refresh_token, data: payload);
      return res.data['access'];
    } catch (e) {
      AppSharedPreference.instance.remove(PrefKeys.TOKEN);
      Get.find<AuthService>().isAuth.value = false;
      throw Exception('err : $e');
    }
  }

  _saveTokenToStorage(String token) {
    AppSharedPreference.instance.setValue(PrefKeys.TOKEN, token);
  }
}
