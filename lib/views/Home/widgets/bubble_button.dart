import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/assets_path.dart';

class BubbleButton extends StatelessWidget {
  final VoidCallback? onTap;
  const BubbleButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        onTap?.call();
      },
      backgroundColor: AppColors.accentColor_2,
      child: SvgPicture.asset(
        '${AssetsPath.icon}/bubble_chat.svg',
      ),
    );
  }
}
