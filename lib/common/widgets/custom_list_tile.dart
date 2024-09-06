import 'package:flutter/material.dart';

import '../constants/app_typography.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final String subtitle;
  final TextStyle? subtitleStyle;

  const CustomListTile({
    super.key,
    this.title = '',
    this.subtitle = '',
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleStyle ?? AppTypography.p5,
        ),
        Text(
          subtitle,
          style: subtitleStyle ?? AppTypography.h6,
        ),
      ],
    );
  }
}
