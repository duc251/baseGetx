import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_size_device.dart';
import '../constants/app_spacing.dart';

Widget BaseContainer(BuildContext context, Widget child) {
  return Container(
    width: widthDevice(context) - sp32,
    padding: const EdgeInsets.all(sp16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(sp8),
      color: AppColors.whiteColor,
    ),
    child: child,
  );
}
