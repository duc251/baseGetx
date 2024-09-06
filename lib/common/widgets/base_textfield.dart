import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_typography.dart';

class ValidateTextField extends StatefulWidget {
  const ValidateTextField({
    Key? key,
    this.backgroundColor,
    this.radius,
    this.controller,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    this.padding,
    this.margin,
    this.readOnly = false,
    this.trailingIcon,
    this.cursorColor,
    this.leadingIcon,
    this.focusNode,
    this.onChanged,
    this.obscureText = false,
    this.textInputType,
    this.border,
    this.maxLines,
    this.validator,
    this.formKey,
    this.errorStyle,
    this.initialValue,
    this.onTap,
    this.valueChange,
    this.defaultValue,
    this.emptySuffixIcon,
    this.onClear,
  }) : super(key: key);

  final Color? backgroundColor;
  final Color? cursorColor;
  final double? radius;
  final TextEditingController? controller;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool readOnly;
  final Widget? trailingIcon;
  final Widget? leadingIcon;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final bool obscureText;
  final TextInputType? textInputType;
  final BoxBorder? border;
  final int? maxLines;
  final String? Function(String?)? validator;
  final GlobalKey<FormState>? formKey;
  final TextStyle? errorStyle;
  final String? initialValue;
  final VoidCallback? onTap;
  final String? valueChange;
  final String? defaultValue;
  final Widget? emptySuffixIcon;
  final VoidCallback? onClear;

  @override
  State<ValidateTextField> createState() => _ValidateTextFieldState();
}

class _ValidateTextFieldState extends State<ValidateTextField> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue)
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ValidateTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.valueChange != oldWidget.valueChange) {
      _controller.text = widget.valueChange ?? '';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: AppColors.whiteColor),
      child: TextFormField(
        controller: _controller,
        onTap: () {
          widget.onTap?.call();
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: _focusNode,
        scrollPadding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        obscureText: widget.obscureText,
        maxLines: widget.maxLines,
        keyboardType: widget.textInputType,
        validator: widget.validator,
        onChanged: (value) {
          widget.onChanged?.call(value);
        },
        // scrollPadding: EdgeInsets.zero,
        readOnly: widget.readOnly,
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
          prefixIcon: widget.leadingIcon,
          suffixIcon: _controller.text.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(right: sp12),
                  child: _controller.text != widget.defaultValue
                      ? GestureDetector(
                          onTap: () {
                            _controller.clear();
                            widget.onClear?.call();
                            setState(() {});
                          },
                          child: const Icon(
                            Icons.close,
                            size: 18,
                            color: AppColors.greyColor,
                          ),
                        )
                      : widget.emptySuffixIcon,
                )
              : Padding(
                  padding: const EdgeInsets.only(right: sp12),
                  child: (widget.emptySuffixIcon ?? const SizedBox.shrink())),
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(sp8),
            borderSide: const BorderSide(
              color: AppColors.red_1,
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
          contentPadding: widget.padding ?? const EdgeInsets.all(sp12),
          isCollapsed: true,
          hintText: widget.hintText ?? "",
          hintStyle:
              widget.hintStyle ?? AppTypography.p6.copyWith(color: greyColor),
        ),
        cursorColor: widget.cursorColor ?? AppColors.bg_3,
        cursorWidth: 1,
        style: widget.textStyle ?? AppTypography.p5,
      ),
    );
  }
}
