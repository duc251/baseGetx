import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_size_device.dart';
import '../../../common/constants/app_spacing.dart';
import '../../../common/constants/app_typography.dart';
import '../../../common/constants/assets_path.dart';
import '../../../common/constants/constans.dart';
import '../../../common/widgets/floating_bubble_button/floating_buble_button.dart';
import '../../../local storage/app_shared_preference.dart';
import '../../../views/Home/widgets/bubble_button.dart';
import '/features/app/model/app_model.dart';
import 'app_controller.dart';
import 'app_item.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _appController = Get.put(AppController());
  List<AppModel> _listApp = [];
  String distributorName = '';

  @override
  void initState() {
    var user = jsonDecode(AppSharedPreference.instance.getValue(PrefKeys.USER));
    distributorName = user["fullname"];
    super.initState();
    setState(() {
      _listApp = _appController.listApp;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              child: Image.asset(
            '${AssetsPath.image}/ic_home.png',
            width: widthDevice(context),
            height: heightDevice(context),
            fit: BoxFit.cover,
          )),
          Padding(
            padding: const EdgeInsets.all(0),
            child: CarouselSlider(
              options: CarouselOptions(
                  height: heightDevice(context), viewportFraction: 1),
              items: [
                buildSlider_1(context, _listApp),
                const SizedBox(),
              ],
            ),
          ),
          FloatingChatButton(
            child: BubbleButton(
              onTap: () {
                showMaterialModalBottomSheet(
                    expand: false,
                    context: context,
                    backgroundColor: Colors.black26,
                    builder: (context) => Container(
                          padding: const EdgeInsets.all(sp16),
                          decoration: const BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(sp8),
                              topRight: Radius.circular(sp8),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Yêu cầu hỗ trợ".tr,
                                      style: AppTypography.p1),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      size: sp20,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: sp16),
                              _SupportHelpDesk(
                                onTap: () async {
                                  launchUrl(
                                    Uri(
                                      scheme: "tel",
                                      path: "09xxx",
                                    ),
                                  );
                                },
                                title: "Gửi yêu cầu hỗ trợ".tr,
                              ),
                              const SizedBox(height: sp16),
                              _SupportHelpDesk(
                                onTap: () async {
                                  launchUrl(
                                    Uri(
                                      scheme: "tel",
                                      path: "09xxx",
                                    ),
                                  );
                                },
                                title: "Gọi tới hỗ trợ của Long Hải".tr,
                              ),
                              const SizedBox(height: sp16),
                              _SupportHelpDesk(
                                onTap: () async {
                                  launchUrl(
                                    Uri(
                                      scheme: "tel",
                                      path: "09xxx",
                                    ),
                                  );
                                },
                                title: "Gọi tới bộ phận kỹ thuật ứng dụng".tr,
                              ),
                            ],
                          ),
                        ));
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
            color: AppColors.borderColor_3,
            borderRadius: BorderRadius.circular(sp8)),
        child: Text(
          title,
          style: AppTypography.p5,
        ),
      ),
    );
  }
}
