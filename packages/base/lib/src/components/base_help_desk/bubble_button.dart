part of base_lhe;

class BubbleButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  const BubbleButton({
    super.key,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        onTap?.call();
      },
      backgroundColor: accentColor_2,
      child: child
    );
  }
}
