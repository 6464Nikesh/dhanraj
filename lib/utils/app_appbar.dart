import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppAppbar {
  static AppBar appBar(String title) {
    return AppBar(
      elevation: 2,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.white,
      backgroundColor: Colors.white,
      centerTitle: false,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: "roboto",
          color: AppColors.navyBlue,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
