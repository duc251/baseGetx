import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_spacing.dart';
import '../../common/constants/app_typography.dart';

class Profit {
  final double revenue;
  final double profit;

  Profit({required this.revenue, required this.profit});
}

class ProfitChart extends StatefulWidget {
  const ProfitChart({Key? key}) : super(key: key);

  @override
  State<ProfitChart> createState() => _ProfitChartState();
}

class _ProfitChartState extends State<ProfitChart> {
  late int showingTooltip;
  static List<Profit> listProfit = [
    Profit(profit: 0, revenue: 0),
    Profit(profit: 0, revenue: 0),
    Profit(profit: 0, revenue: 0),
    Profit(profit: 0, revenue: 0),
    Profit(profit: 0, revenue: 0),
    Profit(profit: 0, revenue: 0),
  ];

  @override
  void initState() {
    showingTooltip = -1;
    super.initState();
  }

  BarChartGroupData generateGroupData(double profit, double revenue) {
    return BarChartGroupData(
      x: profit.toInt(),
      showingTooltipIndicators: showingTooltip == profit.toInt() ? [0] : [],
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: revenue,
          color: AppColors.blue_2,
          borderRadius: BorderRadius.circular(8),
          rodStackItems: <BarChartRodStackItem>[
            BarChartRodStackItem(0, profit, AppColors.mainColor)
          ],
        ),
      ],
    );
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
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
      case 5:
        text = Text('T6', style: style);
        break;
      default:
        text = const SizedBox.shrink();
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: sp4,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = AppTypography.p7.copyWith(color: AppColors.greyColor);
    String text;
    switch (value.ceil()) {
      case 1:
        text = '1K';
        break;
      case 2:
        text = '2K';
        break;
      case 3:
        text = '3K';
        break;
      case 4:
        text = '4K';
        break;
      case 5:
        text = '5K';
        break;
      case 6:
        text = '6K';
        break;
      default:
        return const SizedBox();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Row(
                  children: [
                    Text(
                      "Biểu đồ".tr,
                      style: AppTypography.h5,
                    ),
                    const Spacer(),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.blue_2,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: sp4),
                    Text(
                      "Doanh thu".tr,
                      style: AppTypography.h5,
                    ),
                    const SizedBox(width: sp16),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.mainColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: sp4),
                    Text(
                      "Lợi nhuận".tr,
                      style: AppTypography.h5,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: sp24),
              Expanded(
                child: BarChart(
                  BarChartData(
                    maxY: 6.1,
                    minY: 0,
                    alignment: BarChartAlignment.spaceAround,
                    titlesData: FlTitlesData(
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 16,
                              getTitlesWidget: (value, meta) {
                                return const SizedBox();
                              }),
                        ),
                        topTitles: AxisTitles(),
                        leftTitles: AxisTitles(sideTitles: leftTitles()),
                        bottomTitles: AxisTitles(sideTitles: bottomTitles)),
                    gridData: FlGridData(
                      drawVerticalLine: false,
                      drawHorizontalLine: true,
                      horizontalInterval: 1,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: AppColors.borderColor_4,
                          strokeWidth: 0.5,
                          dashArray: [12, 10],
                        );
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: listProfit
                        .map((e) => generateGroupData(e.profit, e.revenue))
                        .toList(),
                    barTouchData: BarTouchData(
                        enabled: true,
                        handleBuiltInTouches: false,
                        touchCallback: (event, response) {
                          if (response != null &&
                              response.spot != null &&
                              event is FlTapUpEvent) {
                            setState(() {
                              final x = response.spot!.touchedBarGroup.x;
                              final isShowing = showingTooltip == x;
                              if (isShowing) {
                                showingTooltip = -1;
                              } else {
                                showingTooltip = x;
                              }
                            });
                          }
                        },
                        mouseCursorResolver: (event, response) {
                          return response == null || response.spot == null
                              ? MouseCursor.defer
                              : SystemMouseCursors.click;
                        }),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
