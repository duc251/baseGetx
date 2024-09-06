import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

class BottomTransitionWidget extends StatefulWidget {
  final bool isSelected;
  final Widget? child;

  const BottomTransitionWidget({
    Key? key,
    this.isSelected = false,
    this.child,
  }) : super(key: key);

  @override
  State<BottomTransitionWidget> createState() => _BottomTransitionWidgetState();
}

class _BottomTransitionWidgetState extends State<BottomTransitionWidget>
    with TickerProviderStateMixin {
  late AnimationController positionController;
  late Animation<Offset> positionAnimation;

  @override
  void initState() {
    super.initState();
    positionController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    positionAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: positionController, curve: Curves.bounceIn)
        ..addStatusListener(
          (status) {},
        ),
    );
  }

  @override
  void dispose() {
    positionController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BottomTransitionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected != widget.isSelected) {
      if (widget.isSelected) {
        positionController.forward();
      } else {
        positionController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: positionAnimation,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: sp12, horizontal: sp16),
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                spreadRadius: 6,
                blurRadius: 30,
                offset: Offset(0, 0.1),
              ),
            ],
          ),
          child: widget.child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}
