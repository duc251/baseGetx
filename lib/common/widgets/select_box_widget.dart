import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../common/constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import '../constants/assets_path.dart';
import '../model/select_model.dart';
import 'cached_image_widget.dart';

enum StatusSelect {
  UNFOCUS,
  FOCUS_SELECT,
  FOCUS_SEARCH,
}

class SelectBoxWidget extends StatefulWidget {
  const SelectBoxWidget({
    super.key,
    required this.label,
    this.hintSelect = '',
    this.listSelectItem = const [],
    this.unselectedIcon,
    this.unselectedHintText,
    this.customerId,
    this.value,
  });

  final String? label;
  final String hintSelect;
  final List<SelectModel> listSelectItem;
  final Widget? unselectedIcon;
  final String? unselectedHintText;
  final Function(int)? customerId;
  final Function(dynamic)? value;

  @override
  State<SelectBoxWidget> createState() => _SelectBoxWidgetState();
}

class _SelectBoxWidgetState extends State<SelectBoxWidget>
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
  List<SelectModel> currentList = [];

  void _onTap() {
    if (_statusSelect != StatusSelect.FOCUS_SEARCH) {
      _statusSelect = StatusSelect.FOCUS_SEARCH;
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }

  @override
  void initState() {
    super.initState();
    _editTextController = TextEditingController();
    currentList = widget.listSelectItem;
    _controllerDropdownAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animationDropDown = CurvedAnimation(
      parent: _controllerDropdownAnimation,
      curve: Curves.fastOutSlowIn,
    );

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context).insert(_overlayEntry);
        _controllerDropdownAnimation.forward();
      } else {
        _controllerDropdownAnimation.reverse().then(
              (value) => _overlayEntry.remove(),
            );
        _statusSelect = StatusSelect.UNFOCUS;
        _editTextController.text = '';
      }
    });
    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controllerDropdownAnimation,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _editTextController.dispose();
    _controllerDropdownAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(sp16),
      decoration: BoxDecoration(
          color: AppColors.bg_4, borderRadius: BorderRadius.circular(sp8)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.label != null)
                AutoSizeText(
                  widget.label!,
                  style: AppTypography.p6,
                ),
              if (widget.label != null) const SizedBox(height: sp16),
              CompositedTransformTarget(
                link: _layerLink,
                child: InkWell(
                  onTap: () => _onTap(),
                  child: AnimatedContainer(
                    padding: const EdgeInsets.symmetric(
                      vertical: sp8,
                      horizontal: sp16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(sp8),
                      color: AppColors.whiteColor,
                      border: Border.all(
                        color: _statusSelect != StatusSelect.UNFOCUS
                            ? AppColors.mainColor
                            : AppColors.borderColor_4,
                      ),
                    ),
                    duration: const Duration(milliseconds: 250),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.borderColor_1),
                          ),
                          child: selectItem != null &&
                                  selectItem!.img != "Chưa có thông tin"
                              ? CachedImageWidget(
                                  url: selectItem?.img ??
                                      'https://www.shutterstock.com/image-vector/red-store-vector-sign-promotion-260nw-1918121837.jpg',
                                  height: 48,
                                  width: 48,
                                  shape: BoxShape.circle,
                                )
                              : Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.borderColor_1,
                                  ),
                                  height: 48,
                                  width: 48,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      '${AssetsPath.icon}/ic_user.svg',
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(width: sp8),
                        if (selectItem != null)
                          AutoSizeText(
                            selectItem?.label ?? '',
                            style: AppTypography.p5,
                            overflow: TextOverflow.ellipsis,
                          )
                        else
                          _statusSelect == StatusSelect.FOCUS_SELECT ||
                                  _statusSelect == StatusSelect.UNFOCUS
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Chưa chọn',
                                      style: AppTypography.p6,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: sp4),
                                    AutoSizeText(
                                      widget.unselectedHintText ??
                                          'Nhấn để chọn',
                                      style: AppTypography.p6
                                          .copyWith(color: AppColors.greyColor),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                )
                              : Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    focusNode: _focusNode,
                                    controller: _editTextController,
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        currentList = widget.listSelectItem;
                                      }
                                      final newList = currentList
                                          .where((e) => e.label.contains(value))
                                          .toList();
                                      currentList = newList;
                                      _overlayEntry.markNeedsBuild();
                                    },
                                    onSubmitted: null,
                                    decoration: InputDecoration(
                                      hintText: widget.hintSelect,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                        const Spacer(),
                        if (selectItem != null)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectItem = null;
                                widget.customerId?.call(0);
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              size: sp16,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width - 32,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height - 58),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 250),
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: sp16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sp8),
                  color: AppColors.whiteColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      spreadRadius: 30,
                      blurRadius: 30,
                      offset: Offset(0, 0.1),
                    ),
                  ],
                ),
                child: AnimatedBuilder(
                  animation: _controllerDropdownAnimation,
                  builder: (context, child) {
                    return SizeTransition(
                      sizeFactor: _animationDropDown,
                      axis: Axis.vertical,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: _opacityAnimation.value,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                _focusNode.unfocus();
                                setState(() {
                                  selectItem = currentList[index];
                                  _statusSelect = StatusSelect.UNFOCUS;
                                  _editTextController.text = '';
                                  widget.customerId
                                      ?.call(selectItem?.value ?? 0);
                                  widget.value?.call(selectItem?.value);
                                  currentList = widget.listSelectItem;
                                });
                              },
                              child: SelectBoxListTile(
                                leading: currentList[index].img != null &&
                                        currentList[index].img! !=
                                            "Chưa có thông tin"
                                    ? CachedImageWidget(
                                        url: currentList[index].img ??
                                            'https://www.shutterstock.com/image-vector/red-store-vector-sign-promotion-260nw-1918121837.jpg',
                                        height: 48,
                                        width: 48,
                                        shape: BoxShape.circle,
                                      )
                                    : Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.borderColor_1,
                                        ),
                                        height: 48,
                                        width: 48,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            '${AssetsPath.icon}/ic_user.svg',
                                          ),
                                        ),
                                      ),
                                title: currentList[index].label.trim(),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: sp16);
                          },
                          itemCount: currentList.length,
                        ),
                      ),
                    );
                  },
                )),
          ),
        ),
      ),
    );
  }
}

class SelectBoxListTile extends StatelessWidget {
  final Widget? leading;
  final String? title;
  final String? subtitle;

  const SelectBoxListTile({Key? key, this.leading, this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: sp16),
      child: Row(
        children: [
          leading ?? const SizedBox.shrink(),
          const SizedBox(width: sp8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  style: AppTypography.p6,
                ),
                const SizedBox(height: sp4),
                Text(
                  subtitle ?? '',
                  style: AppTypography.p6.copyWith(
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
