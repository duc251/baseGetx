import 'address.dart';
import 'collaborator.dart';
import 'profile.dart';

class UserModel {
  int? id;
  String? fullname;
  String? username;
  String? email;
  bool? isActive;
  int? status;
  String? accountCode;
  String? systemKey;
  List<dynamic>? parentStaf;
  List<Address>? address;
  List<Profile>? profile;
  List<Collaborator>? collaborator;

  UserModel({
    this.id,
    this.fullname,
    this.username,
    this.email,
    this.isActive,
    this.status,
    this.accountCode,
    this.systemKey,
    this.parentStaf,
    this.address,
    this.profile,
    this.collaborator,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as int?,
        fullname: json['fullname'] as String?,
        username: json['username'] as String?,
        email: json['email'] as String?,
        isActive: json['is_active'] as bool?,
        status: json['status'] as int?,
        accountCode: json['account_code'] as String?,
        systemKey: json['system_key'] as String?,
        parentStaf: json['parent_staf'] as List<dynamic>?,
        address: (json['address'] as List<dynamic>?)
            ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
            .toList(),
        profile: (json['profile'] as List<dynamic>?)
            ?.map((e) => Profile.fromJson(e as Map<String, dynamic>))
            .toList(),
        collaborator: (json['collaborator'] as List<dynamic>?)
            ?.map((e) => Collaborator.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullname': fullname,
        'username': username,
        'email': email,
        'is_active': isActive,
        'status': status,
        'account_code': accountCode,
        'system_key': systemKey,
        'parent_staf': parentStaf,
        'address': address?.map((e) => e.toJson()).toList(),
        'profile': profile?.map((e) => e.toJson()).toList(),
        'collaborator': collaborator?.map((e) => e.toJson()).toList(),
      };
}
