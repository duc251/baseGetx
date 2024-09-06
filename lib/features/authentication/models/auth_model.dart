import '../../account/model/account_model.dart';

class AuthModel {
  String? token;
  AccountModel? account;

  AuthModel({
    required this.token,
    required this.account,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    account = json['account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = this.token;
    data['account'] = this.account;
    return data;
  }
}
