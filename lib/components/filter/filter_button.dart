import 'package:flutter/material.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_size_device.dart';
import '../../common/constants/app_spacing.dart';
import '../../common/constants/app_typography.dart';

class FilterButton extends StatelessWidget {
  final List<Map<String, dynamic>> listFilter;
  final dynamic selectFilter;
  final Function handleSelectFilter;

  const FilterButton(
      this.listFilter, this.selectFilter, this.handleSelectFilter,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: new BoxConstraints(
        minHeight: 36,
        maxHeight: 36,
        maxWidth: widthDevice(context),
        minWidth: widthDevice(context),
      ),
      // width: widthDevice(context),
      // height: 40,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: sp16),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        // physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => handleSelectFilter(listFilter[index]['value']),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: sp8, horizontal: sp12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(sp8),
                color: listFilter[index]['value'] == selectFilter
                    ? AppColors.accentColor_5
                    : AppColors.whiteColor,
              ),
              child: Center(
                child: Text(
                  listFilter[index]['title'],
                  style: AppTypography.p5.copyWith(
                    color: listFilter[index]['value'] == selectFilter
                        ? AppColors.whiteColor
                        : AppColors.greyColor,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: listFilter.length,
      ),
    );
  }
}
