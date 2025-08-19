import 'dart:convert';
import 'dart:ffi' hide Size;

import 'package:dhanraj/model/login_model.dart';
import 'package:dhanraj/model/sign_up_model.dart';
import 'package:dhanraj/services/networking.dart';
import 'package:dhanraj/utils/app_api_end_point.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/app_widget.dart';
import 'package:dhanraj/utils/miscellaneous.dart';
import 'package:dhanraj/utils/preference_key.dart';
import 'package:flutter/cupertino.dart' hide Size;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProviderSignUp extends ChangeNotifier with Networking {
  TextEditingController firstName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController lastName = TextEditingController();
  bool isPasswordShow = true;
  bool isConfirmPasswordShow = true;
  SharedPreferences? sp;

  setPasswordVisibility() {
    if (isPasswordShow) {
      isPasswordShow = false;
    } else {
      isPasswordShow = true;
    }
    notifyListeners();
  }

  setConfirmPasswordVisibility() {
    if (isConfirmPasswordShow) {
      isConfirmPasswordShow = false;
    } else {
      isConfirmPasswordShow = true;
    }
    notifyListeners();
  }

  bool validation(BuildContext context) {
    RegExp? regex = RegExp(Miscellaneous.emailPattern);
    if (firstName.text.trim().isEmpty) {
      AppWidget().snackBar(context, "${AppStrings.pleaseEnter} ${AppStrings.firstName}", AppColors.red, Colors.white);
      return false;
    } else if (lastName.text.trim().isEmpty) {
      AppWidget().snackBar(context, "${AppStrings.pleaseEnter} ${AppStrings.lastName}", AppColors.red, Colors.white);
      return false;
    } else if (mobile.text.trim().isEmpty) {
      AppWidget().snackBar(context, "${AppStrings.pleaseEnter} ${AppStrings.mobileNo}", AppColors.red, Colors.white);
      return false;
    } else if (email.text.trim().isEmpty) {
      AppWidget().snackBar(context, "${AppStrings.pleaseEnter} ${AppStrings.emailId}", AppColors.red, Colors.white);
      return false;
    } else if (email.text.trim().isNotEmpty && !regex.hasMatch(email.text.trim())) {
      AppWidget().snackBar(context, "${AppStrings.pleaseEnter} ${AppStrings.valid} ${AppStrings.emailId}", AppColors.red, Colors.white);
      return false;
    } else if (password.text.trim().isEmpty) {
      AppWidget().snackBar(context, "${AppStrings.pleaseEnter} ${AppStrings.password}", AppColors.red, Colors.white);
      return false;
    } else if (confirmPassword.text.trim().isEmpty) {
      AppWidget().snackBar(context, "${AppStrings.pleaseEnter} ${AppStrings.confirmPassword}", AppColors.red, Colors.white);
      return false;
    } else if (password.text.trim() != confirmPassword.text.trim()) {
      AppWidget().snackBar(context, AppStrings.passwordIsNotMatched, AppColors.red, Colors.white);
      return false;
    }
    return true;
  }

  login({required BuildContext context}) async {
    sp = await SharedPreferences.getInstance();
    if (validation(context)) {
      var postMap = {
        "first_name": firstName.text.trim(),
        "last_name": lastName.text.trim(),
        "mobile": mobile.text.trim(),
        "email": email.text.trim(),
        "password": password.text.trim(),
        "confirm_password": confirmPassword.text.trim(),
        "parent_user_id": "1",
        "initial_balance": 10000
      };

      post(context: context, mapData: postMap, endPoint: AppApiEndPoint.signUpUser, isLoaderShow: true, fromBottomSheet: false).then(
        (value) {
          if (value != null) {
            SignUpModel signUpModel = SignUpModel.fromJson(value);
            showSuccessBottomSheet(context, signUpModel.message ?? "");
          }
        },
      );
    }
  }

  Future<void> openBrowserUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // Opens in browser
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  void showSuccessBottomSheet(BuildContext context, String msg) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: false,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 60,
              ),
              const SizedBox(height: 10),
              Text(
                "Success!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                msg,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: AppColors.blue),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: Text(
                        AppStrings.login,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "roboto",
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
