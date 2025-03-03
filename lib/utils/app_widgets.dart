import 'package:dhanraj/utils/app_assets.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';

class AppWidgets {
  static Widget noData(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppAssets.funds,
          scale: 2,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          AppStrings.noOpenPositions,
          style: TextStyle(
            fontFamily: "roboto",
            fontSize: 18,
            color: AppColors.darkBlue,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          AppStrings.toSubmitATradeTapOn,
          style: TextStyle(
            fontFamily: "roboto",
            fontSize: 18,
            color: AppColors.darkBlue,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
