import 'package:flutter/material.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_spacing.dart';

Widget ChangeQuantity(Function minus, Function plus, Function fieldQuantity,
    int quantity, int id) {
  TextEditingController quantityController = TextEditingController(text: '0');
  final FocusNode quantityFn = FocusNode();
  quantityController.text = quantity.toString();
  return Container(
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(sp8),
    ),
    padding: EdgeInsets.symmetric(vertical: sp8, horizontal: sp16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            minus();
          },
          child: const Icon(
            Icons.remove,
            size: 16,
          ),
        ),
        SizedBox(
          width: 70,
          child: TextFormField(
            decoration: const InputDecoration(
              isCollapsed: true,
              contentPadding: EdgeInsets.all(4),
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.number,
            controller: quantityController,
            focusNode: quantityFn,
            textAlign: TextAlign.center,
            onChanged: (value) => fieldQuantity(value, id),
          ),
        ),
        InkWell(
          onTap: () {
            plus();
          },
          child: const Icon(
            Icons.add,
            size: 16,
          ),
        ),
      ],
    ),
  );
}
