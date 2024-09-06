import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import '../constants/assets_path.dart';
import '../routes/app_routes.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.backgroundColor,
    this.title = '',
    this.textStyle,
    this.onTap,
    this.leadingIcon,
    required this.hasBack,
    this.trailingIcons,
    this.iconColor,
    this.centerTitle = false,
    this.hasArrow = true,
  }) : super(key: key);

  final Color? backgroundColor;
  final String title;
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  final Widget? leadingIcon;
  final bool hasBack;
  final List<Widget>? trailingIcons;
  final Color? iconColor;
  final bool centerTitle;
  final bool hasArrow;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? AppColors.whiteColor,
      title: Text(
        title,
        style: textStyle ?? AppTypography.h5,
      ),
      leading: GestureDetector(
        onTap: () {
          if (hasBack) {
            Navigator.pop(context);
          } else {
            onTap?.call();
          }
        },
        child: leadingIcon ??
            (hasArrow
                ? const Icon(Icons.arrow_back, color: AppColors.blackColor)
                : const SizedBox.shrink()),
      ),
      actions: trailingIcons ??
          [
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.routeNotification);
              },
              child: SvgPicture.asset(
                '${AssetsPath.icon}/ic_bell.svg',
              ),
            ),
            const SizedBox(width: sp24),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.routeAccount);
              },
              child: SvgPicture.asset(
                '${AssetsPath.icon}/ic_person.svg',
              ),
            ),
            const SizedBox(width: sp16),
          ],
    );
  }
}
