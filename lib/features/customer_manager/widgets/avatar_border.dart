import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';

import '../../../common/util/api.dart';

class AvatarBorder extends StatelessWidget {
  const AvatarBorder({
    super.key,
    this.borderColor,
    this.pathAvatar,
  });
  final Color? borderColor;
  final String? pathAvatar;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                (pathAvatar != "" && pathAvatar != null)
                    ? pathAvatar!
                    : Api.defaultLogo,
              ),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            width: 1.5,
            color: borderColor_1.withOpacity(.3),
          )),
    );
  }
}
