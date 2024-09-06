import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';

class OrderModel {
  String getStatusString(status) {
    if (status == 1) {
      return "Chờ vận chuyển";
    } else if (status == 2) {
      return "Đang vận chuyển";
    }

    return "Sẵn sàng";
  }

  Color getStatusColor(status) {
    if (status == 1) {
      return blue_1;
    } else if (status == 2) {
      return yellow_1;
    }

    return green_1;
  }

  Color getStatusColor2(status) {
    if (status == 1) {
      return blue_2;
    } else if (status == 2) {
      return yellow_2;
    }
    return green_2;
  }
}
