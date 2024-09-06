import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';
import 'package:lhe_ctv/common/constants/app_typography.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const CustomAppBar(
        hasBack: true,
        trailingIcons: [],
        title: "Đơn hủy",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            baseContainer(
              Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image:
                            NetworkImage("https://via.placeholder.com/64x64"),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 0.75, color: Color(0xFFECEFF5)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Combo hamburger - khoai tây',
                              style: AppTypography.p3,
                            ),
                            const SizedBox(height: 4),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'NSP000001 - ',
                                      style: AppTypography.p6
                                          .copyWith(color: greyColor)),
                                  TextSpan(
                                      text: '3 sản phẩm',
                                      style: AppTypography.p5
                                          .copyWith(color: greyColor)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Tổng tiền: ',
                                      style: AppTypography.p6
                                          .copyWith(color: greyColor)),
                                  TextSpan(
                                      text: '160.000 VNĐ',
                                      style: AppTypography.p5
                                          .copyWith(color: mainColor)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
