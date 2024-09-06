part of base_lhe;

Widget BaseContainer(BuildContext context, Widget child,
    {double? width, double? height, Color? color, double? padding}) {
  return Container(
    width: width ?? widthDevice(context) - sp32,
    height: height,
    padding: EdgeInsets.all(padding ?? sp16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(sp8),
      color: color ?? whiteColor,
    ),
    child: child,
  );
}

Widget baseContainer(Widget child,
    {double? width, double? height, Color? color, double? padding}) {
  return Container(
    width: width,
    height: height,
    padding: EdgeInsets.all(padding ?? sp16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(sp8),
      color: color ?? whiteColor,
    ),
    child: child,
  );
}
