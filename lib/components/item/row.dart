import 'package:flutter/material.dart';

import '../../common/constants/app_typography.dart';

Widget buildRowItem({
  required String title,
  required String content,
  final TextStyle? contentTextStyle,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(title, style: AppTypography.p6),
      ),
      Expanded(
        child: Text(
          content,
          style: contentTextStyle ?? AppTypography.h6,
          textAlign: TextAlign.right,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}

Widget buildRowText({
  required String title,
  required String content,
  TextStyle? style,
  TextStyle? styleTitle,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("$title ", style: styleTitle ?? AppTypography.p6),
      Text(
        content,
        style: style ?? AppTypography.p5,
        textAlign: TextAlign.right,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}
