import 'package:dhanraj/utils/app_assets.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';

class AppWidget {
  Widget loader(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: AppColors.blue,
            ),
          ],
        ),
      ),
    );
  }

  snackBar(BuildContext context, String text, Color color, Color textColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: textColor,
              ),
        ),
        backgroundColor: color,
      ),
    );
  }

  snackBarTop(BuildContext context, String text, Color color, Color textColor) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
            ),
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  static Widget noDataFound(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.emptyBox,
            scale: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            AppStrings.noDataAvailable,
            style: Theme.of(context).textTheme.labelLarge,
          )
        ],
      ),
    );
  }

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
