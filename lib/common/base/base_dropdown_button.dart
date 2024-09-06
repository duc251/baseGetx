import 'package:flutter/material.dart';
import '../constants/app_typography.dart';

InputDecoration baseInputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFD9DCE0),
      width: 1,
    ),
    borderRadius: BorderRadius.circular(8),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFD9DCE0),
      width: 1,
    ),
    borderRadius: BorderRadius.circular(8),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFD9DCE0),
      width: 1,
    ),
    borderRadius: BorderRadius.circular(8),
  ),
  contentPadding: EdgeInsets.symmetric(horizontal: 16),
);

Widget baseDropDownButton(String label, Widget dropdownButton) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$label',
        style: AppTypography.p5,
      ),
      SizedBox(height: 4),
      Card(
        elevation: 0,
        child: dropdownButton,
      ),
    ],
  );
}
