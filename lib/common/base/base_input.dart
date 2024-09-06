import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

class BaseTextField extends StatefulWidget {
  const BaseTextField({
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

  @override
  State<BaseTextField> createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BaseTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.valueChange != oldWidget.valueChange) {
      _controller.text = widget.valueChange ?? '';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(_focusNode);
          },
          child: Container(
            padding: widget.padding ?? const EdgeInsets.all(sp12),
            margin: widget.margin,
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? AppColors.whiteColor,
              borderRadius: BorderRadius.circular(widget.radius ?? sp8),
              border: widget.border ??
                  Border.all(
                    color: _focusNode.hasFocus
                        ? AppColors.mainColor
                        : AppColors.borderColor_2,
                  ),
            ),
            child: Row(
              children: [
                (widget.leadingIcon != null)
                    ? Padding(
                        padding: const EdgeInsets.only(right: sp8),
                        child: widget.leadingIcon!,
                      )
                    : const SizedBox(),
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    onTap: () {
                      widget.onTap?.call();
                    },
                    focusNode: _focusNode,
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    obscureText: widget.obscureText,
                    maxLines: widget.maxLines,
                    keyboardType: widget.textInputType,
                    onChanged: (value) {
                      widget.onChanged?.call(value);
                    },
                    // scrollPadding: EdgeInsets.zero,
                    readOnly: widget.readOnly,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isCollapsed: true,
                      hintText: widget.hintText ?? "",
                      hintStyle: widget.hintStyle ?? AppTypography.p5,
                    ),
                    cursorColor: widget.cursorColor ?? AppColors.bg_3,
                    cursorWidth: 1,
                    style: widget.textStyle ?? AppTypography.p5,
                  ),
                ),
                (widget.trailingIcon != null)
                    ? Padding(
                        padding: const EdgeInsets.only(left: sp8),
                        child: widget.trailingIcon!,
                      )
                    : _controller.text.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(left: sp8),
                            child: GestureDetector(
                              onTap: () {
                                _controller.clear();
                                setState(() {});
                              },
                              child: const Icon(Icons.close,
                                  size: 18, color: AppColors.greyColor),
                            ),
                          )
                        : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
        widget.validator != null
            ? const SizedBox(height: sp4)
            : const SizedBox.shrink(),
        widget.validator != null
            ? Text(widget.validator?.call(widget.controller?.text) ?? "",
                style: widget.errorStyle ??
                    AppTypography.p5.copyWith(color: AppColors.red_1))
            : const SizedBox.shrink(),
      ],
    );
  }
}

Widget AppInput({
  required String label,
  required String hintText,
  required TextEditingController? controller,
  required BuildContext context,
  required TextInputType textInputType,
  Widget? suffixIcon,
  required Function validate,
  bool show = true,
  bool isPassword = false,
  bool? enabled,
  int? maxLines = 1,
  FocusNode? fn,
  bool required = false,
  Function? onTap,
  // required Function onChanged
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RichText(
        text: TextSpan(
          text: label,
          style: AppTypography.p5.copyWith(color: AppColors.blackColor),
          children: [
            if (required)
              TextSpan(
                  text: ' *',
                  style: AppTypography.p5.copyWith(color: AppColors.red_1))
          ],
        ),
      ),
      // Text('$label', style: AppTypography.p5),
      SizedBox(height: sp8.sp),
      TextFormField(
        onTap: () {
          if (onTap != null) onTap();
        },
        maxLines: maxLines,
        keyboardType: textInputType,
        controller: controller,
        obscureText: !show,
        enabled: enabled,
        focusNode: fn,
        validator: (value) {
          return validate(value);
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12),
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.borderColor_2,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.blue_1,
              width: 1,
            ),
          ),
          hintText: hintText,
          hintStyle: AppTypography.p6.copyWith(color: AppColors.greyColor),
          // label: Text(
          //   label,
          //   style: AppTypography.p5,
          // ),
          suffixIcon: suffixIcon,
          // isPassword
          //   ? IconButton(
          //       icon: Icon(
          //         show ? Icons.visibility : Icons.visibility_off_outlined,
          //       ),
          //       onPressed: () {
          //         _loginController.changeShowPassword(value: show ? false.obs : true.obs);
          //       },
          //     )
          //   : Spacer(),
        ),
      ),
    ],
  );
}

class InputCurrency extends StatelessWidget {
  final String? label;
  final String hintText;
  final TextEditingController controller;
  final BuildContext context;
  final Widget? suffixIcon;
  final Function validate;
  final FocusNode? fn;
  final bool required;

  const InputCurrency({
    super.key,
    required this.label,
    required this.hintText,
    required this.context,
    required this.suffixIcon,
    required this.validate,
    required this.controller,
    this.fn,
    this.required = false,
  });

  static const _locale = 'vi';

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          RichText(
            text: TextSpan(
              text: '$label',
              style: AppTypography.p5.copyWith(color: AppColors.blackColor),
              children: [
                if (required)
                  TextSpan(
                      text: ' *',
                      style: AppTypography.p5.copyWith(color: AppColors.red_1))
              ],
            ),
          ),
        if (label != null) const SizedBox(height: sp8),
        TextFormField(
          keyboardType: TextInputType.number,
          controller: controller,
          focusNode: fn,
          onChanged: (string) {
            string = _formatNumber(string.replaceAll('.', ''));
            controller.value = TextEditingValue(
              text: string,
              selection: TextSelection.collapsed(offset: string.length),
            );
          },
          validator: (value) {
            return validate(value);
          },
          decoration: InputDecoration(
            prefixText: _currency,
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.borderColor_2,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.blue_1,
                width: 1,
              ),
            ),
            hintText: hintText,
            hintStyle: AppTypography.p6.copyWith(color: AppColors.greyColor),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
