import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../base/base_loading.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import '../constants/assets_path.dart';
import '../model/select_model.dart';
import 'base_textfield.dart';

enum StatusSelect {
  UNFOCUS,
  FOCUS_SELECT,
  FOCUS_SEARCH,
}

class BaseDropDownBox extends StatefulWidget {
  const BaseDropDownBox({
    super.key,
    this.listItems = const [],
    this.onTap,
    this.label,
    this.selectedItem,
    this.hintText,
    this.isOverlayOpened,
    this.isLoading = false,
    this.layerLink,
    this.defaultValue,
    this.validator,
    this.onClear,
  });

  final String? label;
  final List<SelectModel> listItems;
  final Function(int)? onTap;
  final Function(SelectModel)? selectedItem;
  final String? hintText;
  final String? defaultValue;
  final Function(bool)? isOverlayOpened;
  final bool isLoading;
  final LayerLink? layerLink;
  final String? Function(String?)? validator;
  final VoidCallback? onClear;

  @override
  State<BaseDropDownBox> createState() => _BaseDropDownBoxState();
}

class _BaseDropDownBoxState extends State<BaseDropDownBox>
    with TickerProviderStateMixin {
  StatusSelect _statusSelect = StatusSelect.UNFOCUS;
  late LayerLink _layerLink;
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _editTextController;
  OverlayEntry _overlayEntry = OverlayEntry(builder: (BuildContext context) {
    return const SizedBox.shrink();
  });
  late AnimationController _controllerDropdownAnimation;
  late Animation<double> _animationDropDown;
  late Animation<double> _opacityAnimation;
  SelectModel? selectItem;
  Timer? timer;
  late String title;
  List<SelectModel> currentList = [];
  bool isLoading = false;

  void _onTap() {
    if (_statusSelect != StatusSelect.FOCUS_SEARCH) {
      _statusSelect = StatusSelect.FOCUS_SEARCH;
      FocusScope.of(context).requestFocus(_focusNode);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _layerLink = widget.layerLink ?? LayerLink();
    title = widget.label ?? '';
    currentList = widget.listItems;
    isLoading = widget.isLoading;
    _editTextController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
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
        widget.isOverlayOpened?.call(true);
        _controllerDropdownAnimation.forward();
      } else {
        _controllerDropdownAnimation.reverse();
        Timer(const Duration(milliseconds: 200), () {
          _overlayEntry.remove();
          widget.isOverlayOpened?.call(false);
        });
        _statusSelect = StatusSelect.UNFOCUS;
        _editTextController.text = '';
        currentList = widget.listItems;
      }
    });
  }

  @override
  void didUpdateWidget(covariant BaseDropDownBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.label != widget.label) {
      title = widget.label!;
      setState(() {});
    }
    if (oldWidget.listItems != widget.listItems) {
      currentList = widget.listItems;
      setState(() {});
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (oldWidget.isLoading != widget.isLoading) {
        isLoading = widget.isLoading;
        _overlayEntry.markNeedsBuild();
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
              child: _statusSelect == StatusSelect.FOCUS_SEARCH
                  ? TextField(
                      keyboardType: TextInputType.text,
                      focusNode: _focusNode,
                      controller: _editTextController,
                      maxLines: 1,
                      onChanged: (value) {
                        _handleSearch(value);
                      },
                      onSubmitted: null,
                      scrollPadding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(sp8),
                            borderSide: const BorderSide(
                              color: AppColors.borderColor_2,
                              width: 1,
                            )),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 5,
                          minHeight: 5,
                        ),
                        isDense: true,
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 5,
                          minHeight: 5,
                        ),
                        suffixIcon: _editTextController.text.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  _editTextController.clear();
                                  currentList = widget.listItems;
                                  _overlayEntry.markNeedsBuild();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(right: sp12),
                                  child: Icon(
                                    Icons.close,
                                    size: 18,
                                    color: AppColors.greyColor,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(sp8),
                          borderSide: const BorderSide(
                            color: AppColors.mainColor,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(sp8),
                          borderSide: const BorderSide(
                            color: AppColors.borderColor_2,
                            width: 1,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(sp8),
                          borderSide: const BorderSide(
                            color: AppColors.borderColor_2,
                            width: 1,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(sp12),
                        isCollapsed: true,
                        hintText: widget.hintText ?? "",
                        hintStyle: AppTypography.p6.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                    )
                  : ValidateTextField(
                      defaultValue: widget.defaultValue,
                      initialValue: title,
                      maxLines: 1,
                      onClear: widget.onClear,
                      textStyle: title == widget.defaultValue
                          ? AppTypography.p6
                              .copyWith(color: AppColors.greyColor)
                          : AppTypography.p6,
                      hintText: widget.hintText ?? "",
                      emptySuffixIcon: SvgPicture.asset(
                        '${AssetsPath.icon}/ic_black_arrow_down.svg',
                      ),
                      readOnly: true,
                      valueChange: title,
                      onTap: () {
                        _onTap();
                      },
                      hintStyle:
                          AppTypography.p6.copyWith(color: AppColors.greyColor),
                      onChanged: (value) {
                        _handleSearch(value);
                      },
                      validator: widget.validator,
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
      builder: (context) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, size.height + sp4),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
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
                      child: isLoading
                          ? const Center(child: BaseLoading())
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    widget.onTap?.call(index);
                                    _focusNode.unfocus();
                                    setState(() {
                                      _statusSelect = StatusSelect.UNFOCUS;
                                      title = currentList[index].label;
                                      widget.selectedItem
                                          ?.call(currentList[index]);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(sp12),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          getBorderRadius(index, currentList),
                                      color: widget.listItems[index] == title
                                          ? AppColors.mainColor
                                          : AppColors.whiteColor,
                                    ),
                                    child: DefaultTextStyle(
                                      style: AppTypography.p6.copyWith(
                                        color: currentList[index] != title
                                            ? AppColors.blackColor
                                            : AppColors.whiteColor,
                                      ),
                                      child: Text(
                                        currentList[index].label,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: currentList.length,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  BorderRadius getBorderRadius(int index, List<SelectModel> listItem) {
    if (index == 0 && listItem.length != 1) {
      return const BorderRadius.only(
        topLeft: Radius.circular(sp8),
        topRight: Radius.circular(sp8),
      );
    } else if (index == listItem.length - 1 && listItem.length != 1) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(sp8),
        bottomRight: Radius.circular(sp8),
      );
    } else if (listItem.length == 1) {
      return BorderRadius.circular(sp8);
    } else {
      return BorderRadius.zero;
    }
  }

  void _handleSearch(String keyword) {
    if (keyword.isEmpty) {
      currentList = widget.listItems;
      _overlayEntry.markNeedsBuild();
      return;
    }
    final list = currentList
        .where((element) => element.label.contains(keyword))
        .toList();
    currentList = list;
    _overlayEntry.markNeedsBuild();
  }
}
