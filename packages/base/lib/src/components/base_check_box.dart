part of base_lhe;

class BaseCheckbox extends StatelessWidget {
  const BaseCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final Function(bool? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sp4)),
      side: const BorderSide(width: 2, color: greyColor),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      splashRadius: sp8,
      checkColor: whiteColor,
      fillColor: MaterialStateProperty.all(mainColor),
      value: value,
      onChanged: (value) {
        onChanged.call(value);
      },
    );
  }
}
