part of base_lhe;

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

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: centerTitle,
      titleSpacing: 0,
      backgroundColor: backgroundColor ?? whiteColor,
      title: Text(
        title,
        style: textStyle ?? h5,
      ),
      automaticallyImplyLeading: false,
      leading: leadingIcon ??
          GestureDetector(
            onTap: () {
              if (hasBack) {
                Navigator.pop(context);
              } else {
                onTap?.call();
              }
            },
            child: leadingIcon ??
                const Icon(
                  Icons.arrow_back,
                  color: blackColor,
                  size: 20,
                ),
          ),
      actions: trailingIcons ??
          [
            SvgPicture.asset(
              '${AssetsPath.icon}/ic_bell.svg',
            ),
            const SizedBox(width: sp24),
            SvgPicture.asset(
              '${AssetsPath.icon}/ic_person.svg',
            ),
            const SizedBox(width: sp16),
          ],
    );
  }
}
