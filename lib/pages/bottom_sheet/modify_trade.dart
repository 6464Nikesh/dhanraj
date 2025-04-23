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
                      Navigator.pushNamed(context, AppRoutes.modifyTarget);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        AppStrings.modifyTarget,
                        style: TextStyle(
                          fontFamily: "roboto",
                          fontSize: 18,
                          color: AppColors.navyBlue,
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      AppStrings.modifyStopLoss,
                      style: TextStyle(
                        fontFamily: "roboto",
                        fontSize: 18,
                        color: AppColors.navyBlue,
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      AppStrings.extendTime,
                      style: TextStyle(
                        fontFamily: "roboto",
                        fontSize: 18,
                        color: AppColors.navyBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
