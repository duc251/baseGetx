class Profile {
  String? profileName;

  Profile({this.profileName});

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        profileName: json['profile_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'profile_name': profileName,
      };
}
