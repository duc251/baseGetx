import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../base/base_loading.dart';
import '../constants/app_colors.dart';
import '../constants/app_size_device.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import '../constants/assets_path.dart';
import '../widgets/calendar_picker.dart';
import '../widgets/custom_button.dart';

class DialogUtils {
  static showSuccessDialog(
    BuildContext context, {
    required String content,
    VoidCallback? accept,
    VoidCallback? extraAccept,
    String? icon,
    String? mainTitle,
    String? extraTitle,
    bool hasButton = true,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: sp32),
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: sp24, horizontal: sp16),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(sp8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.whiteColor,
                  child: SvgPicture.asset(
                    '${AssetsPath.icon}/${icon ?? "ic_success.svg"}',
                  ),
                ),
                const SizedBox(height: sp24),
                Text('Thông báo'.tr, style: AppTypography.h3),
                const SizedBox(height: sp12),
                Text(
                  content,
                  style: AppTypography.p4.copyWith(color: AppColors.greyColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: sp24),
                hasButton
                    ? Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ExtraButton(
                              title: extraTitle ?? 'Quay lại'.tr,
                              onTap: () {
                                extraAccept != null
                                    ? extraAccept.call()
                                    : Get.back();
                              },
                              borderColor: AppColors.borderColor_4,
                              largeButton: true,
                              icon: null,
                            ),
                          ),
                          const SizedBox(width: sp12),
                          Expanded(
                            child: MainButton(
                              title: mainTitle ?? 'Xác nhận'.tr,
                              onTap: accept ?? () => Get.back(),
                              largeButton: true,
                              icon: null,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }

  static showDialogWithTitleAndOptionButton(BuildContext context,
      {required String content, required VoidCallback okButton}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              Center(child: Text(content)),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("CANCEL")),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      okButton();
                    },
                    child: const Text("OK"),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  static showLoadingDialog(
    BuildContext context, {
    String? content,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: sp24, horizontal: sp16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(sp8),
            ),
            width: max(widthDevice(context) - sp32, 343),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BaseLoading(),
                const SizedBox(height: sp24),
                Text('Thông báo'.tr, style: AppTypography.h3),
                const SizedBox(height: sp12),
                Text(
                  content ?? "Đang xử lý...",
                  style: AppTypography.p4.copyWith(color: AppColors.blackColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static showErrorDialog(
    BuildContext context, {
    String? content,
    VoidCallback? accept,
    VoidCallback? extraAccept,
    Widget? widgetContent,
    String? icon,
    String? mainTitle,
    String? extraTitle,
    String? label,
    bool hasButton = true,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: sp32),
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: sp24, horizontal: sp16),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(sp8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.whiteColor,
                  child: SvgPicture.asset(
                    '${AssetsPath.icon}/ic_error.svg',
                  ),
                ),
                const SizedBox(height: sp24),
                Text(label ?? 'Thông báo'.tr, style: AppTypography.h3),
                const SizedBox(height: sp12),
                widgetContent ?? const SizedBox(),
                if (content != null)
                  Text(
                    content,
                    style:
                        AppTypography.p4.copyWith(color: AppColors.greyColor),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: sp24),
                hasButton
                    ? Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ExtraButton(
                              title: extraTitle ?? 'Quay lại'.tr,
                              onTap: () {
                                extraAccept != null
                                    ? extraAccept.call()
                                    : Get.back();
                              },
                              borderColor: AppColors.borderColor_4,
                              largeButton: true,
                              icon: null,
                            ),
                          ),
                          const SizedBox(width: sp12),
                          Expanded(
                            child: MainButton(
                              title: mainTitle ?? 'Xác nhận'.tr,
                              onTap: accept ?? () => Get.back(),
                              largeButton: true,
                              icon: null,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> showCalendarDialog(BuildContext context,
      {required List<String?> selectedDate,
      Function(String)? onConfirm,
      DateRangePickerSelectionMode selectionMode =
          DateRangePickerSelectionMode.range}) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        reverseTransitionDuration: const Duration(milliseconds: 0),
        transitionDuration: const Duration(milliseconds: 100),
        pageBuilder: (_, __, ___) {
          return Material(
            elevation: 0,
            color: Colors.transparent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Listener(
                    onPointerDown: (_) {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      color: Colors.black26,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: sp12),
                  child: Material(
                    elevation: 1,
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(sp8),
                    child: Container(
                      padding: const EdgeInsets.all(sp12),
                      child: CalendarPicker(
                        selectionMode: selectionMode,
                        selectedDate: selectedDate,
                        onConfirm: (value) {
                          onConfirm?.call(value);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
