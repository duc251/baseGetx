import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import '../constants/assets_path.dart';
import '../model/select_model.dart';

enum StatusSelect {
  UNFOCUS,
  FOCUS_SELECT,
  FOCUS_SEARCH,
}

class CustomDropDownBox extends StatefulWidget {
  const CustomDropDownBox({
    super.key,
    this.exportDestination = const [],
    this.onTap,
    this.label,
    this.selectedItem,
  });

  final String? label;
  final List<String> exportDestination;
  final Function(int)? onTap;
  final Function(String)? selectedItem;

  @override
  State<CustomDropDownBox> createState() => _CustomDropDownBoxState();
}

class _CustomDropDownBoxState extends State<CustomDropDownBox>
    with TickerProviderStateMixin {
  StatusSelect _statusSelect = StatusSelect.UNFOCUS;
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _editTextController;
  late OverlayEntry _overlayEntry;
  late AnimationController _controllerDropdownAnimation;
  late Animation<double> _animationDropDown;
  late Animation<double> _opacityAnimation;
  SelectModel? selectItem;
  Timer? timer;
  late String title;

  void _onTap() {
    if (_statusSelect != StatusSelect.FOCUS_SEARCH) {
      _statusSelect = StatusSelect.FOCUS_SEARCH;
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }

  @override
  void initState() {
    super.initState();
    title = widget.label ?? '';
    _editTextController = TextEditingController();
    _controllerDropdownAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animationDropDown = CurvedAnimation(
      parent: _controllerDropdownAnimation,
      curve: Curves.fastOutSlowIn,
    );

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controllerDropdownAnimation,
        curve: Curves.linear,
      ),
    );

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context).insert(_overlayEntry);
        _controllerDropdownAnimation.forward();
      } else {
        _controllerDropdownAnimation.reverse();
        Timer(const Duration(milliseconds: 200), () {
          _overlayEntry.remove();
        });
        _statusSelect = StatusSelect.UNFOCUS;
        _editTextController.text = '';
      }
    });
  }

  @override
  void dispose() {
    _controllerDropdownAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CompositedTransformTarget(
              link: _layerLink,
              child: InkWell(
                onTap: () => _onTap(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(sp12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(sp8),
                    border: Border.all(
                      color: _statusSelect != StatusSelect.UNFOCUS
                          ? AppColors.mainColor
                          : AppColors.borderColor_2,
                    ),
                    color: AppColors.whiteColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: AppTypography.p6.copyWith(
                          color: _statusSelect != StatusSelect.UNFOCUS ||
                                  title != "Chọn đối tượng xuất hàng".tr
                              ? AppColors.blackColor
                              : AppColors.greyColor,
                        ),
                      ),
                      SvgPicture.asset(
                        '${AssetsPath.icon}/ic_black_arrow_down.svg',
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + sp4),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(sp8),
              color: AppColors.borderColor_1,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  spreadRadius: 6,
                  blurRadius: 30,
                  offset: Offset(0, 0.1),
                ),
              ],
            ),
            child: AnimatedBuilder(
              animation: _controllerDropdownAnimation,
              builder: (context, child) => SizeTransition(
                sizeFactor: _animationDropDown,
                axis: Axis.vertical,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _opacityAnimation.value,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          widget.onTap?.call(index + 1);
                          _focusNode.unfocus();
                          setState(() {
                            _statusSelect = StatusSelect.UNFOCUS;
                            title = widget.exportDestination[index];
                            widget.selectedItem?.call(title);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(sp12),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(sp8),
                              bottomRight: Radius.circular(sp8),
                            ),
                            color: AppColors.whiteColor,
                          ),
                          child: Text(
                            widget.exportDestination[index],
                            style: AppTypography.p6,
                          ),
                        ),
                      );
                    },
                    itemCount: widget.exportDestination.length,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
