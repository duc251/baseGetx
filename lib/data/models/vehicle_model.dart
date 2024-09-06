import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';

class VehicleModel {
  int? id;
  String? vehicleName;
  String? vehcleCode;
  String? licensePlates;
  String? maxWeight;
  int? status;
  bool? active;
  String? url;

  VehicleModel({
    this.id,
    this.vehicleName,
    this.vehcleCode,
    this.licensePlates,
    this.maxWeight,
    this.status,
    this.active,
    this.url,
  });
  String getStatusString() {
    if (status == 1) {
      return "Chờ vận chuyển";
    } else if (status == 2) {
      return "Đang vận chuyển";
    }

    return "Sẵn sàng";
  }

  Color getStatusColor() {
    if (status == 1) {
      return blue_1;
    } else if (status == 2) {
      return yellow_1;
    }

    return green_1;
  }

  Color getStatusColor2() {
    if (status == 1) {
      return blue_2;
    } else if (status == 2) {
      return yellow_2;
    }

    return green_2;
  }

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        id: json['id'] as int?,
        vehicleName: json['vehicle_name'] as String?,
        vehcleCode: json['vehcle_code'] as String?,
        licensePlates: json['license_plates'] as String?,
        maxWeight: json['max_weight'] as String?,
        status: json['status'] as int?,
        active: json['active'] as bool?,
        url: json['url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'vehicle_id': id,
        'vehicle_name': vehicleName,
        'vehcle_code': vehcleCode,
        'license_plates': licensePlates,
        'max_weight': maxWeight,
      };

  VehicleModel copyWith({
    int? id,
    String? vehicleName,
    String? vehcleCode,
    String? licensePlates,
    String? maxWeight,
    int? status,
    bool? active,
    String? url,
  }) {
    return VehicleModel(
      id: id ?? this.id,
      vehicleName: vehicleName ?? this.vehicleName,
      vehcleCode: vehcleCode ?? this.vehcleCode,
      licensePlates: licensePlates ?? this.licensePlates,
      maxWeight: maxWeight ?? this.maxWeight,
      status: status ?? this.status,
      active: active ?? this.active,
      url: url ?? this.url,
    );
  }
}
