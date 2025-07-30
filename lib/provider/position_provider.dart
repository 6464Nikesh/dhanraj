import 'dart:convert';

import 'package:dhanraj/model/login_model.dart';
import 'package:dhanraj/model/position_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/total_margin_model.dart';
import '../services/networking.dart';
import '../utils/app_api_end_point.dart';
import '../utils/preference_key.dart';

class PositionProvider extends ChangeNotifier {
  List<Trades> trades = [];
  SharedPreferences? sp;
  LoginModel? loginModel;
  num latestBalance = 0;
  num margin = 0;

  Map<String, int> commodityMultipliers = {
    'GOLD': 100,
    'GOLDM': 10,
    'SILVER': 30,
    'SILVERM': 5,
    'CRUDEOIL': 100,
    'NATURALGAS': 1250,
    'COPPER': 1000,
    'LEAD': 5000,
    'LEADMINI': 1000,
    'ZINC': 5000,
    'ZINCMINI': 1000,
    'ALUMINIUM': 5000,
    'ALUMINIUMMINI': 1000,
  };

  clear() {
    trades.clear();
  }

  getPrefData({required BuildContext context}) async {
    sp = await SharedPreferences.getInstance();
    String data = sp?.getString(PreferenceKey.loginData) ?? "";
    loginModel = LoginModel.fromJson(jsonDecode(data));
    notifyListeners();
    initData(context: context);
  }

  Future<void> initData({required BuildContext context}) async {
    await getPositionList(context: context);
    await totalMargins(context: context);
  }

  String removeTrailingZeros(String value) {
    double val = double.tryParse(value) ?? 0.0;

    if (val == 0) return '';
    if (value.contains('.')) {
      // Remove trailing zeros and dot if nothing remains after dot
      value = " ${value.replaceFirst(RegExp(r'\.0+$'), '')}"; // e.g., 12.0000 -> 12
    }
    return value;
  }

  getPositionList({required BuildContext context}) {
    Networking().get(context: context, endPoint: AppApiEndPoint.position, isShowLoader: true).then(
      (value) {
        if (value != null) {
          PositionModel positionModel = PositionModel.fromJson(value);
          totalMargins(context: context);
          if (positionModel.statusCode == 200) {
            trades = positionModel.result?.trades ?? [];

            for (var i = 0; i < trades.length; ++i) {
              margin = margin + (trades[i].requiredMargin ?? 0);
            }
            notifyListeners();
          }
        }
      },
    );
  }

  totalMargins({required BuildContext context}) async {
    String id = loginModel?.result?.user?.userId.toString() ?? "";

    Networking().getWithParams(context: context, endPoint: AppApiEndPoint.totalMargins, isShowLoader: true, params: "/$id").then(
      (value) {
        if (value != null) {
          TotalMarginModel totalMarginModel = TotalMarginModel.fromJson(value);

          if (totalMarginModel.statusCode == 200) {
            latestBalance = num.parse(totalMarginModel.result?.latestBalance ?? "");

            notifyListeners();
          }
        }
      },
    );
  }
}
