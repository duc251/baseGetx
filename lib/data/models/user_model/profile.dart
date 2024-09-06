class Profile {
  int? profileId;
  String? value;
  String? profileName;
  String? profileType;

  Profile({this.profileId, this.value, this.profileName, this.profileType});

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        profileId: json['profile_id'] as int?,
        value: json['value'] as String?,
        profileName: json['profile_name'] as String?,
        profileType: json['profile_type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'profile_id': profileId,
        'value': value,
        'profile_name': profileName,
        'profile_type': profileType,
      };
}
