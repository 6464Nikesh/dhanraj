import 'dart:convert';
import 'dart:ffi';

import 'package:dhanraj/model/login_model.dart';
import 'package:dhanraj/services/networking.dart';
import 'package:dhanraj/utils/app_api_end_point.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/app_widget.dart';
import 'package:dhanraj/utils/preference_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderLogin extends ChangeNotifier with Networking {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isPasswordShow = false;
  SharedPreferences? sp;

  setVisibility() {
    if (isPasswordShow) {
      isPasswordShow = false;
    } else {
      isPasswordShow = true;
    }
    notifyListeners();
  }

  bool validation(BuildContext context) {
    if (userName.text.trim().isEmpty) {
      AppWidget().snackBar(context, AppStrings.pleaseEnterUsername, AppColors.red, Colors.white);
      return false;
    } else if (password.text.trim().isEmpty) {
      AppWidget().snackBar(context, AppStrings.pleaseEnterPassword, AppColors.red, Colors.white);
      return false;
    }
    return true;
  }

  login({required BuildContext context}) async {
    sp = await SharedPreferences.getInstance();
    if (validation(context)) {
      Map<String, dynamic> postMap = {
        "usernameoremail": userName.text.trim(),
        "password": password.text.trim(),
        "loginType": "username",
      };
      post(context: context, mapData: postMap, endPoint: AppApiEndPoint.loginUser, isLoaderShow: true, fromBottomSheet: false).then(
        (value) {
          if (value != null) {
            LoginModel loginModel = LoginModel.fromJson(value);
            if (loginModel.result?.user?.roleType == "CLIENT" && loginModel.result?.user?.accountStatus == "ACTIVE") {
              sp?.setString(PreferenceKey.token, loginModel.result?.token ?? "");
              sp?.setString(PreferenceKey.loginData, json.encode(loginModel.result));
              Navigator.pushNamed(context, AppRoutes.dashboard);
            } else {
              AppWidget().snackBar(context, AppStrings.youAreNotAllowedToLogin, AppColors.red, Colors.white);
            }
          }
        },
      );
    }
  }
}
