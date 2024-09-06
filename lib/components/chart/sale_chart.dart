import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_spacing.dart';
import '../../common/constants/app_typography.dart';

class _LineChart extends StatelessWidget {
  const _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 5,
        maxY: 4,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(tooltipBgColor: AppColors.bg_4),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(sideTitles: bottomTitles, axisNameSize: 5),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = AppTypography.p7.copyWith(color: AppColors.greyColor);
    String text;
    switch (value.toInt()) {
      case 1:
        text = '90';
        break;
      case 2:
        text = '180';
        break;
      case 3:
        text = '270';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = AppTypography.p7.copyWith(color: AppColors.greyColor);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('T1', style: style);
        break;
      case 1:
        text = Text('T2', style: style);
        break;
      case 2:
        text = Text('T3', style: style);
        break;
      case 3:
        text = Text('T4', style: style);
        break;
      case 4:
        text = Text('T5', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(
        drawHorizontalLine: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppColors.borderColor_4,
            strokeWidth: 0.5,
          );
        },
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Colors.transparent,
          ),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: AppColors.mainColor,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        // spots: const [
        //   FlSpot(0, 1),
        //   FlSpot(1, 1.5),
        //   FlSpot(2, 1.4),
        //   FlSpot(3, 3.4),
        //   FlSpot(4, 2),
        //   FlSpot(5, 2.2),
        // ],
      );
}

class RevenueChart extends StatefulWidget {
  const RevenueChart({super.key});

  @override
  State<StatefulWidget> createState() => RevenueChartState();
}

class RevenueChartState extends State<RevenueChart> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: DecoratedBox(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppColors.whiteColor
            // gradient: LinearGradient(
            //   colors: [
            //     Color(0xff2c274c),
            //     Color.fromARGB(255, 129, 171, 71),
            //   ],
            //   begin: Alignment.bottomCenter,
            //   end: Alignment.topCenter,
            // ),
            ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: sp16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Doanh thu',
                        style: AppTypography.h5,
                        textAlign: TextAlign.center,
                      ),
                      // SizedBox(
                      //   width: 120,
                      //   child: BaseSelect(
                      //     list: ['Tháng này'],
                      //     select: 'Tháng này',
                      //     handleSelect: () {},
                      //     hint: '',
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: sp8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 6),
                    child: _LineChart(isShowingMainData: isShowingMainData),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: sp16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: sp8, horizontal: sp16),
                    decoration: BoxDecoration(
                      color: AppColors.bg_4,
                      borderRadius: BorderRadius.circular(sp8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.blue_1,
                        ),
                        const SizedBox(width: sp8),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Tổng: ',
                                  style: AppTypography.p6
                                      .copyWith(color: AppColors.blackColor)),
                              TextSpan(
                                  text: '0 VNĐ',
                                  style: AppTypography.h6
                                      .copyWith(color: AppColors.blackColor)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: sp16)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
