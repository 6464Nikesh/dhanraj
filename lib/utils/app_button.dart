import 'package:dhanraj/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton {
  static Widget button({required String text, required BuildContext context}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.navyBlue,
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: "roboto",
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  static Widget colorButton({
    required String text,
    required BuildContext context,
    required Color color,
    required Color textColor,
    required bool isActive,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isActive ? color : color.withOpacity(0.5),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 40),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontFamily: "roboto",
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  static Widget outLineButton({
    required String text,
    required BuildContext context,
    required bool isActive,
  }) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.blue)),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: "roboto",
              color: AppColors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
