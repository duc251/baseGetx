import 'package:flutter/material.dart';

class AppModel {
  final Widget logo;
  final String title;
  final dynamic routeName;
  bool show;

  AppModel({
    required this.logo,
    required this.title,
    required this.routeName,
    required this.show,
  });
}
