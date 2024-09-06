import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lhe_ctv/common/util/base_dio.dart';
import 'package:lhe_ctv/data/models/order_model.dart';
import 'package:lhe_ctv/data/models/product_model/product_model.dart';
import '../../common/constants/constans.dart';
import '../../common/util/api.dart';
import '../../local storage/app_shared_preference.dart';
import '../models/customer_model/customer_model.dart';

class CustomerModelProvider {
  final _dio = BaseDio().dio();
  Future<List<CustomerModel>?> getAllCustomer(dynamic data) async {
    try {
      final response =
          await _dio.post('${Api.shop}/get_collaborators_users', data: data);
      if (response.statusCode == 200) {
        return (response.data['data']['results'] as List)
            .map((e) => CustomerModel.fromJson(e))
            .toList();
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw e.response?.data['error'];
      } else {
        throw e.response?.data['message'] ?? e.toString();
      }
    } catch (e) {
      throw e.toString();
    }
    return null;
  }

  Future<List<ProductModel>?> getAllProduct(dynamic data) async {
    try {
      final response =
          await _dio.post('${Api.product}/all_formula_price', data: data);
      if (response.statusCode == 200) {
        return (response.data['data']['results'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw e.response?.data['error'];
      } else {
        throw e.response?.data['message'] ?? e.toString();
      }
    } catch (e) {
      throw e.toString();
    }
    return null;
  }

  Future<bool> deactiveCustomer(int customerId) async {
    try {
      final response = await _dio.post(
          '${Api.baseURL}/account/api/account_deactive',
          data: {'account_id': customerId});
      return (response.statusCode == 200);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw e.response?.data['error'];
      } else {
        throw e.response?.data['message'] ?? e.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> updateProfileAccount({String? phone, String? fullname}) async {
    try {
      final Map account = json
          .decode(AppSharedPreference.instance.getValue(PrefKeys.USER) ?? '');
      final response =
          await _dio.post('${Api.baseURL}/account/api/update_profile',
              data: FormData.fromMap({
                'phone': phone,
                'fullname': fullname,
                'system_key': account['system_key'],
                "account_id": account['id'],
              }));
      return (response.statusCode == 200);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw e.response?.data['error'];
      } else {
        throw e.response?.data['message'] ?? e.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<CustomerModel>?> getAllCustomerDone() async {
    try {
      final response = await _dio.get(
        '${Api.customer}/all_customer',
      );
      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((e) => CustomerModel.fromJson(e))
            .toList();
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw e.response?.data['error'];
      } else {
        throw e.response?.data['message'] ?? e.toString();
      }
    } catch (e) {
      throw e.toString();
    }
    return null;
  }

  deleteOrder(int driverId) {}

  createOrder(OrderModel value, {required XFile avatar}) {}

  updateOrder(OrderModel value, {required XFile avatar}) {}

  getAllOrder(Map<String, String> data) {}
}
