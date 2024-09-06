import 'profile.dart';

class AccountProfileAccount {
  int? id;
  Profile? profile;
  String? value;

  AccountProfileAccount({this.id, this.profile, this.value});

  factory AccountProfileAccount.fromJson(Map<String, dynamic> json) {
    return AccountProfileAccount(
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
      value: json['value'] as String?,
      id: json['id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'profile': profile?.toJson(),
        'value': value,
      };
}
