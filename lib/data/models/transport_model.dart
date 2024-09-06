import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';

class TransportModel {
  int? id;
  int? customerId;
  int? vehicleId;
  String? transportCode;
  dynamic startTime;
  dynamic endTime;
  int? status;
  String? phoneNumber;
  String? customerName;
  String? vehicleName;
  String? licensePlates;

  TransportModel({
    this.id,
    this.customerId,
    this.vehicleId,
    this.transportCode,
    this.startTime,
    this.endTime,
    this.status,
    this.phoneNumber,
    this.customerName,
    this.vehicleName,
    this.licensePlates,
  });
  String getStatusString() {
    if (status == 1) {
      return "Đang vận chuyển";
    } else if (status == 2) {
      return "Hoàn thành";
    }
    return "Chờ vận chuyển";
  }

  Color getStatusColor() {
    if (status == 1) {
      return yellow_1;
    } else if (status == 2) {
      return green_1;
    }

    return blue_1;
  }

  Color getStatusColor2() {
    if (status == 1) {
      return yellow_2;
    } else if (status == 2) {
      return green_2;
    }

    return blue_2;
  }

  factory TransportModel.fromJson(Map<String, dynamic> json) {
    return TransportModel(
      id: json['id'] as int?,
      customerId: json['customer_id'] as int?,
      vehicleId: json['vehicle_id'] as int?,
      transportCode: json['transport_code'] as String?,
      startTime: json['start_time'] as dynamic,
      endTime: json['end_time'] as dynamic,
      status: json['status'] as int?,
      phoneNumber: json['phone_number'] as String?,
      customerName: json['customer_name'] as String?,
      vehicleName: json['vehicle_name'] as String?,
      licensePlates: json['license_plates'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'customer_id': customerId,
        'vehicle_id': vehicleId,
        'transport_code': transportCode,
        'start_time': startTime,
        'end_time': endTime,
        'status': status,
        'phone_number': phoneNumber,
        'customer_name': customerName,
        'vehicle_name': vehicleName,
        'license_plates': licensePlates,
      };
}
