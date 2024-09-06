import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../util/enum/tab_item.dart';

Widget buildBottomBar(
  BuildContext context,
  TabItemCode? pageIndex,
  Function(TabItemCode code) changeTab,
) {
  return SizedBox(
    height: 116,
    width: widthDevice(context),
    child: Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: CustomPaint(
            size: Size(widthDevice(context), 80),
            painter: BNBCustomPainter(context: context),
          ),
        ),
        Center(
          heightFactor: 1,
          child: SizedBox(
            width: 64,
            height: 64,
            child: FloatingActionButton(
              key: GlobalKey(),
              elevation: 4,
              onPressed: () {
                Get.offAllNamed(Routes.routeHomeScreen);
              },
              backgroundColor: mainColor,
              child: SvgPicture.asset(
                '${AssetsPath.image}/icon_home.svg',
                width: 21,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 24),
          height: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {
                    changeTab(TabItemCode.order);
                  },
                  icon: SvgPicture.asset(
                    '${AssetsPath.image}/icon_warehouse.svg',
                    width: 18,
                    color:
                        pageIndex == TabItemCode.order ? mainColor : greyColor,
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    changeTab(TabItemCode.report);
                  },
                  icon: SvgPicture.asset(
                    '${AssetsPath.image}/icon_user.svg',
                    width: 16,
                    color:
                        pageIndex == TabItemCode.report ? mainColor : greyColor,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

class BNBCustomPainter extends CustomPainter {
  final context;

  BNBCustomPainter({required this.context});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = whiteColor
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(0, 0, 16, 0);
    path.lineTo(size.width * 0.357, 0);
    path.quadraticBezierTo(size.width * 0.385, 0, size.width * 0.405, 13.5);
    // path.arcToPoint(Offset(size.width*0.6, 20), radius: Radius.circular(8), clockwise: false);
    path.quadraticBezierTo(size.width * 0.445, 36, size.width * 0.5, 36);
    path.quadraticBezierTo(size.width * 0.555, 36, size.width * 0.595, 13.5);
    path.quadraticBezierTo(size.width * 0.615, 0, size.width * 0.643, 0);
    path.lineTo(size.width - 16, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 20);
    path.lineTo(size.width, 80);
    path.lineTo(0, 80);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawShadow(path, Colors.black45, 1, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
