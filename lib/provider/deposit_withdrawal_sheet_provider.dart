import 'dart:convert';
import 'dart:io';
import 'package:dhanraj/provider/provider_funds.dart';
import 'package:dhanraj/services/networking.dart';
import 'package:dhanraj/utils/app_api_end_point.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_model.dart';
import '../utils/preference_key.dart';

class DepositWithdrawalSheetProvider extends ChangeNotifier {
  String selectedPage = "deposit";

  File? selectedFile;

  String companyName = "";
  SharedPreferences? sp;
  LoginModel? loginModel;

  TextEditingController depositFundsController = TextEditingController();
  TextEditingController fileController = TextEditingController();
  TextEditingController transactionTypeController = TextEditingController();
  TextEditingController transactionIdController = TextEditingController();
  TextEditingController withdrawalFundsController = TextEditingController();
  TextEditingController depositNoteController = TextEditingController();
  TextEditingController withdrawalNoteController = TextEditingController();

  clear() {
    selectedFile = null;
    depositFundsController.clear();
    fileController.clear();
    transactionTypeController.clear();
    transactionIdController.clear();
    withdrawalFundsController.clear();
    depositNoteController.clear();
    withdrawalNoteController.clear();

  }

  getPrefData() async {
    sp = await SharedPreferences.getInstance();
    String data = sp?.getString(PreferenceKey.loginData) ?? "";

    if (data.isNotEmpty) {
      loginModel = LoginModel.fromJson(jsonDecode(data));
      companyName = loginModel?.result?.user?.companyName ?? "";
    }

    notifyListeners();
  }

  changePage({required String value}) {
    selectedPage = value;
    notifyListeners();
  }

  selSelectedFile(File file) {
    selectedFile = file;
    fileController.text = file.path ?? "";
    notifyListeners();
  }

  removeSelectedFile() {
    selectedFile = null;
    fileController.text = "";
    notifyListeners();
  }

  bool depositValidation({required BuildContext context}) {
    if (depositFundsController.text.isEmpty) {
      AppWidget().snackBarTop(context, "Please enter amount.", AppColors.red, Colors.white);
      return false;
    }
    return true;
  }

  bool withdrawalValidation({required BuildContext context}) {
    if (withdrawalFundsController.text.isEmpty) {
      AppWidget().snackBarTop(context, "Please enter amount.", AppColors.red, Colors.white);
      return false;
    }
    return true;
  }

  addFunds({required BuildContext context}) {
    if (!depositValidation(context: context)) {
      return;
    }
    var mapData = {
      "amount": depositFundsController.text,
      "payment_mode": "BANK_TRANSFER",
      "description": depositNoteController.text,
    };
    Networking().post(context: context, mapData: mapData, endPoint: AppApiEndPoint.addFunds, isLoaderShow: true, fromBottomSheet: true).then(
      (value) {
        if (value != null) {
          Provider.of<ProviderFunds>(context, listen: false).getTransactionHistory(context);
          Navigator.pop(context);
        }
      },
    );
  }

  withdrawalFunds({required BuildContext context}) {
    if (!withdrawalValidation(context: context)) {
      return;
    }
    var mapData = {
      "amount": withdrawalFundsController.text,
      "notes": withdrawalNoteController.text,
    };
    Networking().post(context: context, mapData: mapData, endPoint: AppApiEndPoint.withdrawalRequest, isLoaderShow: true, fromBottomSheet: true).then(
      (value) {
        if (value != null) {
          Provider.of<ProviderFunds>(context, listen: false).getTransactionHistory(context);
          Navigator.pop(context);
        }
      },
    );
  }
}
