import 'package:dio/dio.dart';
import 'package:lhe_ctv/common/util/base_dio.dart';
import 'package:lhe_ctv/data/models/user_model/user_model.dart';
import '../../common/util/api.dart';
import '../models/customer_model/customer_model.dart';

class UserModelProvider {
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
      if (response.statusCode == 400) {
        throw response.data['error'];
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

  Future<UserModel?> getDetailUser(int id) async {
    try {
      var dio = BaseDio().dio();
      var res = await dio.get("${Api.getAccountById}/$id");
      if (res.statusCode == 200) {
        return UserModel.fromJson(res.data);
      }
    } catch (err) {
      if (err is DioError) {
        throw err.response!.data.toString();
      }
    }
    return null;
  }
}
