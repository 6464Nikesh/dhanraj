import 'package:dhanraj/utils/app_appbar.dart';
import 'package:dhanraj/utils/app_button.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';

class ModifyTarget extends StatefulWidget {
  const ModifyTarget({super.key});

  @override
  State<ModifyTarget> createState() => _ModifyTargetState();
}

class _ModifyTargetState extends State<ModifyTarget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppbar.appBar(AppStrings.modifyTarget),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    AppStrings.modifyTarget,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.navyBlue,
                      fontFamily: "roboto",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Instrument",
                        style: TextStyle(
                          fontFamily: "roboto",
                          color: AppColors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "NIFTY 05DEC24 24400 CE",
                        style: TextStyle(
                          fontFamily: "roboto",
                          color: AppColors.navyBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Current Target",
                        style: TextStyle(
                          fontFamily: "roboto",
                          color: AppColors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "--",
                        style: TextStyle(
                          fontFamily: "roboto",
                          color: AppColors.navyBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Last Trade Price",
                        style: TextStyle(
                          fontFamily: "roboto",
                          color: AppColors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "₹ 145.95",
                        style: TextStyle(
                          fontFamily: "roboto",
                          color: AppColors.navyBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    AppStrings.newTarget,
                    style: TextStyle(
                      fontFamily: "roboto",
                      color: AppColors.blue,
                      fontSize: 10,
                    ),
                  ),
                  const TextField(
                    cursorColor: AppColors.grey,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AppButton.outLineButton(
                          text: AppStrings.cancel,
                          context: context,
                          isActive: true,
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        child: AppButton.outLineButton(
                          text: AppStrings.update,
                          context: context,
                          isActive: true,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
