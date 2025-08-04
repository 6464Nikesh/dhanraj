import 'dart:convert';

import 'package:dhanraj/services/networking.dart';
import 'package:dhanraj/utils/app_api_end_point.dart';
import 'package:dhanraj/utils/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/add_watch_list_items_model.dart';
import '../model/change_password_model.dart';
import '../model/login_model.dart' as LoginModel;
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../utils/preference_key.dart';

class ProviderChangePassword extends ChangeNotifier {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  SharedPreferences? sp;
  LoginModel.Result? loginModel;

  bool isPasswordCurrentShow = false;
  bool isPasswordNewShow = false;
  bool isPasswordConfirmShow = false;

  clear() {
    currentPassword.clear();
    newPassword.clear();
    confirmPassword.clear();
  }

  setVisibilityCurrent() {
    if (isPasswordCurrentShow) {
      isPasswordCurrentShow = false;
    } else {
      isPasswordCurrentShow = true;
    }
    notifyListeners();
  }

  setVisibilityNew() {
    if (isPasswordNewShow) {
      isPasswordNewShow = false;
    } else {
      isPasswordNewShow = true;
    }
    notifyListeners();
  }

  setVisibilityConfirm() {
    if (isPasswordConfirmShow) {
      isPasswordConfirmShow = false;
    } else {
      isPasswordConfirmShow = true;
    }
    notifyListeners();
  }

  getPrefData() async {
    sp = await SharedPreferences.getInstance();
    String data = sp?.getString(PreferenceKey.loginData) ?? "";
    if (data.isNotEmpty) {
      loginModel = LoginModel.Result.fromJson(jsonDecode(sp?.getString(PreferenceKey.loginData) ?? ""));
    }
    notifyListeners();
  }

  bool validation({required BuildContext context}) {
    if (currentPassword.text.trim().isEmpty) {
      AppWidget().snackBarTop(context, "${AppStrings.enter} ${AppStrings.current} ${AppStrings.password}", AppColors.red, Colors.white);
      return false;
    } else if (newPassword.text.trim().isEmpty) {
      AppWidget().snackBarTop(context, "${AppStrings.enter} ${AppStrings.newPassword}", AppColors.red, Colors.white);
      return false;
    } else if (confirmPassword.text.trim().isEmpty) {
      AppWidget().snackBarTop(context, "${AppStrings.enter} ${AppStrings.confirmPassword}", AppColors.red, Colors.white);
      return false;
    } else if (confirmPassword.text.trim() != newPassword.text.trim()) {
      AppWidget().snackBarTop(context, "${AppStrings.password} ${AppStrings.notMatched}", AppColors.red, Colors.white);
      return false;
    }

    return true;
  }

  changePassword({required BuildContext context}) {
    if (validation(context: context)) {
      var data = {
        "userId": loginModel?.user?.userId ?? "",
        "oldPassword": currentPassword.text.trim(),
        "newPassword": newPassword.text.trim(),
      };

      Networking()
          .post(
        context: context,
        mapData: data,
        endPoint: AppApiEndPoint.changePassword,
        isLoaderShow: true,
        fromBottomSheet: false,
      )
          .then(
        (value) {
          if (value != null) {
            ChangePasswordModel changePasswordModel = ChangePasswordModel.fromJson(value);
            AppWidget().snackBar(context, changePasswordModel.message ?? "", AppColors.green, Colors.white);
            currentPassword.clear();
            newPassword.clear();
            confirmPassword.clear();
            Navigator.pop(context);
          }
        },
      );
    }
  }
}
