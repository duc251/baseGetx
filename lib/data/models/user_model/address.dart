class Address {
  int? id;
  bool? addressDefault;
  String? address;
  String? province;
  String? district;
  String? ward;
  String? latLong;

  Address({
    this.id,
    this.addressDefault,
    this.address,
    this.province,
    this.district,
    this.ward,
    this.latLong,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json['id'] as int?,
        addressDefault: json['default'] as bool?,
        address: json['address'] as String?,
        province: json['province'] as String?,
        district: json['district'] as String?,
        ward: json['ward'] as String?,
        latLong: json['lat_long'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'default': addressDefault,
        'address': address,
        'province': province,
        'district': district,
        'ward': ward,
        'lat_long': latLong,
      };
}
