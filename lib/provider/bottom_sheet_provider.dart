import 'package:dhanraj/model/withdrawal_request_model.dart';
import 'package:dhanraj/services/networking.dart';
import 'package:dhanraj/utils/app_api_end_point.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetProvider extends ChangeNotifier {
  String selectedPage = "deposit";

  TextEditingController depositFundsController = TextEditingController();
  TextEditingController withdrawalFundsController = TextEditingController();
  TextEditingController depositNoteController = TextEditingController();
  TextEditingController withdrawalNoteController = TextEditingController();

  changePage({required String value}) {
    selectedPage = value;
    notifyListeners();
  }

  bool depositValidation({required BuildContext context}) {
    if (depositFundsController.text.isEmpty) {
      AppWidget().snackBarTop(context, "Please enter funds.", AppColors.red, Colors.white);
      return false;
    }
    if (depositNoteController.text.isEmpty) {
      AppWidget().snackBarTop(context, "Please enter note.", AppColors.red, Colors.white);
      return false;
    }
    return true;
  }

  bool withdrawalValidation({required BuildContext context}) {
    if (withdrawalFundsController.text.isEmpty) {
      AppWidget().snackBarTop(context, "Please enter funds.", AppColors.red, Colors.white);
      return false;
    }
    if (withdrawalNoteController.text.isEmpty) {
      AppWidget().snackBarTop(context, "Please enter note.", AppColors.red, Colors.white);
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
      "bank_name": "HDFC Bank",
      "bank_reference": "HDFC123456",
      "description": depositNoteController.text,
    };
    Networking().post(context: context, mapData: mapData, endPoint: AppApiEndPoint.addFunds, isLoaderShow: true, fromBottomSheet: true).then(
      (value) {
        if (value != null) {}
      },
    );
  }

  withdrawalFunds({required BuildContext context}) {
    if (!withdrawalValidation(context: context)) {
      return;
    }
    var mapData = {
      "amount": withdrawalFundsController.text,
      "bank_name": "HDFC Bank",
      "bank_reference": "HDFC123456",
      "notes": withdrawalNoteController.text,
    };
    Networking().post(context: context, mapData: mapData, endPoint: AppApiEndPoint.withdrawalRequest, isLoaderShow: true, fromBottomSheet: true).then(
      (value) {
        if (value != null) {
          WithdrawalRequestModel withdrawalRequestModel = WithdrawalRequestModel.fromJson(value);
          Navigator.pop(context);
        }
      },
    );
  }
}
