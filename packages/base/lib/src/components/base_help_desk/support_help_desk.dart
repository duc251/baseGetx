part of base_lhe;

class _SupportHelpDesk extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const _SupportHelpDesk({
    this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        width: widthDevice(context),
        padding: const EdgeInsets.symmetric(vertical: sp12, horizontal: sp16),
        decoration: BoxDecoration(
            color: borderColor_3,
            borderRadius: BorderRadius.circular(sp8)),
        child: Text(
          title,
          style: p5,
        ),
      ),
    );
  }
}
