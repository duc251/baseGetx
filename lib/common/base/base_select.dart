import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

class BaseSelect extends StatelessWidget {
  List<Map<String, dynamic>>? list;
  Map<String, dynamic>? select;
  Function? handleSelect;
  String? hint;
  Function validator;

  BaseSelect({
    required this.list,
    required this.select,
    required this.handleSelect,
    required this.validator,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Map<String, dynamic>>(
      hint: Text(
        '$hint',
        style: AppTypography.p6.copyWith(color: AppColors.greyColor),
      ),
      isExpanded: true,
      style: AppTypography.p6,
      // underline: Container(
      //   color: Color.fromARGB(0, 0, 0, 0),
      // ),
      value: select,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: sp12, horizontal: sp12),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.red_1),
            borderRadius: BorderRadius.circular(sp8)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.borderColor_2),
            borderRadius: BorderRadius.circular(sp8)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.mainColor),
            borderRadius: BorderRadius.circular(sp8)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.red_1),
            borderRadius: BorderRadius.circular(sp8)),
      ),
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 3,
      onChanged: (Map<String, dynamic>? value) {
        handleSelect!(value);
      },
      validator: (value) {
        return validator(value);
      },
      items: list?.map<DropdownMenuItem<Map<String, dynamic>>>((item) {
        return DropdownMenuItem<Map<String, dynamic>>(
          value: item,
          child: Text(
            item['category_name'],
            style: AppTypography.p6.copyWith(color: AppColors.blackColor),
          ),
        );
      }).toList(),
    );
  }
}
