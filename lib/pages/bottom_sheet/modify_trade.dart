import 'package:dhanraj/utils/app_button.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/app_widget.dart';
import 'package:flutter/material.dart';

class ModifyTrade extends StatefulWidget {
  const ModifyTrade({super.key});

  @override
  State<ModifyTrade> createState() => _ModifyTradeState();
}

class _ModifyTradeState extends State<ModifyTrade> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, 1);
                    },
                    child: AppButton.colorButton(
                      text: AppStrings.modifyTarget,
                      context: context,
                      color: Colors.white,
                      isActive: true,
                      textColor: AppColors.navyBlue,
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, 2);
                    },
                    child: AppButton.colorButton(
                      text: AppStrings.modifyStopLoss,
                      context: context,
                      color: Colors.white,
                      isActive: true,
                      textColor: AppColors.navyBlue,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, 0);
                },
                child: AppButton.colorButton(
                  text: AppStrings.cancel,
                  context: context,
                  color: Colors.white,
                  isActive: true,
                  textColor: AppColors.navyBlue,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
