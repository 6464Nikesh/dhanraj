import 'package:dhanraj/utils/app_appbar.dart';
import 'package:dhanraj/utils/app_button.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppAppbar.appBar(AppStrings.confirmPassword),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 19,
                  ),
                  TextField(
                    cursorColor: AppColors.grey,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                      hintText: "${AppStrings.current} ${AppStrings.password}",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "roboto",
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  TextField(
                    cursorColor: AppColors.grey,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                      hintText: AppStrings.newPassword,
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "roboto",
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  TextField(
                    cursorColor: AppColors.grey,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                      hintText: AppStrings.confirmPassword,
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "roboto",
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(AppStrings.availableBalance),
                          const Text(" : "),
                          const Text("10000.000"),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(AppStrings.charges),
                          const Text(" : "),
                          const Text("100.000"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AppButton.button(text: AppStrings.submit, context: context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
