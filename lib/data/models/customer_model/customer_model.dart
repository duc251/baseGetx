import 'package:get/get.dart';

import '../user_model/address.dart';
import 'account_profile_account.dart';

class CustomerModel {
  int? id;
  String? fullname;
  String? username;
  String? email;
  String? acountCode;
  List<AccountProfileAccount>? accountProfileAccount;
  List<Address>? accountAddress;

  CustomerModel({
    this.id,
    this.acountCode,
    this.fullname,
    this.username,
    this.email,
    this.accountProfileAccount,
    this.accountAddress,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: json['id'] as int?,
        fullname: json['fullname'] as String?,
        username: json['username'] as String?,
        email: json['email'] as String?,
        acountCode: json['account_code'] as String?,
        accountProfileAccount:
            (json['AccountProfile_account'] as List<dynamic>?)
                ?.map((e) =>
                    AccountProfileAccount.fromJson(e as Map<String, dynamic>))
                .toList(),
        accountAddress: (json['account_address'] as List<dynamic>?)
            ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullname': fullname,
        'username': username,
        'email': email,
        'AccountProfile_account':
            accountProfileAccount?.map((e) => e.toJson()).toList(),
        'account_address': accountAddress,
      };

  String? getProfileValue({String? keyword}) {
    if (accountProfileAccount?.isEmpty ?? true) return null;
    final profile = accountProfileAccount!.firstWhereOrNull((element) =>
        element.profile!.profileName?.contains(keyword ?? "avatar") ?? false);
    if (profile != null) {
      return profile.value;
    }
    return null;
  }
}
