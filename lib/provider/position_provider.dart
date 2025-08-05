import 'dart:convert';

import 'package:dhanraj/model/login_model.dart';
import 'package:dhanraj/model/position_model.dart';
import 'package:dhanraj/provider/web_socket_service.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/total_margin_model.dart';
import '../model/update_target_model.dart';
import '../services/networking.dart';
import '../utils/app_api_end_point.dart';
import '../utils/preference_key.dart';

class PositionProvider extends ChangeNotifier {
  List<Trades> trades = [];
  List<Trades> pendingTrades = [];
  SharedPreferences? sp;
  LoginModel? loginModel;
  num latestBalance = 0;
  num margin = 0;
  num totalPnl = 0;
  final newStopLossController = TextEditingController();
  final newTargetController = TextEditingController();

  num get netBalanceWithPnl => latestBalance + totalPnl;

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

  Future<void> init({required BuildContext context}) async {
    totalPnl = 0;
    Provider.of<WebSocketService>(context, listen: false).subscribeToOpenTrades();
    getPrefData(context: context);
    Provider.of<WebSocketService>(context, listen: false).registerContext(context);
  }

  clear() {
    trades.clear();
  }

  updatePnl(num pnl) {
    totalPnl = pnl;
  }

  void recalculateTotalPnl(Map<int, dynamic> liveData) {
    num newTotalPnl = 0;

    for (var trade in trades) {
      int? instrumentToken = int.tryParse(trade.instrumentToken ?? '');
      final symbol = trade.symbolName?.toUpperCase();
      final multiplier = commodityMultipliers[symbol] ?? 1;
      final isBuy = trade.tradeType == 'BUY';
      final quantity = trade.quantity ?? 1;

      final socketData = liveData[instrumentToken];

      if (socketData != null && socketData['instrument_token'] == instrumentToken) {
        num lastPrice = num.parse(socketData['last_price'].toString());
        num openPrice = num.parse(trade.openPrice.toString());

        num priceDiff = isBuy ? lastPrice - openPrice : openPrice - lastPrice;
        num pnl = priceDiff * quantity * multiplier;

        newTotalPnl += pnl;
      }
    }

    totalPnl = newTotalPnl;
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
    margin = 0;
    trades.clear();
    pendingTrades.clear();
    Networking().get(context: context, endPoint: AppApiEndPoint.position, isShowLoader: true).then(
      (value) {
        if (value != null) {
          PositionModel positionModel = PositionModel.fromJson(value);
          totalMargins(context: context);
          if (positionModel.statusCode == 200) {
            for (var i = 0; i < (positionModel.result?.trades?.length ?? 0); ++i) {
              if (positionModel.result?.trades?[i].status == "PENDING") {
                pendingTrades.add(positionModel.result?.trades?[i] ?? Trades());
              } else {
                trades.add(positionModel.result?.trades?[i] ?? Trades());
              }
            }

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
    latestBalance = 0;
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

  updateTarget({
    required BuildContext context,
    required String newTarget,
    required String tradeId,
  }) {
    if (newTargetController.text.isNotEmpty) {
      var data = {
        "takeprofitPrice": newTarget,
      };

      Networking()
          .put(
        context: context,
        endPoint: AppApiEndPoint.position,
        mapData: data,
        params: tradeId,
        isShowLoader: true,
      )
          .then(
        (value) {
          if (value != null) {
            UpdateTargetModel updateTargetModel = UpdateTargetModel.fromJson(value);
            AppWidget().snackBarTop(context, updateTargetModel.message ?? "", AppColors.green, Colors.white);
            newTargetController.clear();
            Navigator.pop(context);
            Navigator.pop(context, true);
          }
        },
      );
    } else {
      AppWidget().snackBarTop(context, "Please enter new target.", AppColors.red, Colors.white);
    }
  }

  updateStopLoss({
    required BuildContext context,
    required String newTarget,
    required String tradeId,
  }) {
    if (newStopLossController.text.isNotEmpty) {
      var data = {
        "stoplossPrice": newTarget,
      };

      Networking()
          .put(
        context: context,
        endPoint: AppApiEndPoint.position,
        mapData: data,
        params: tradeId,
        isShowLoader: true,
      )
          .then(
        (value) {
          if (value != null) {
            UpdateTargetModel updateTargetModel = UpdateTargetModel.fromJson(value);
            AppWidget().snackBarTop(context, updateTargetModel.message ?? "", AppColors.green, Colors.white);
            newStopLossController.clear();
            Navigator.pop(context);
            Navigator.pop(context, true);
          }
        },
      );
    } else {
      AppWidget().snackBarTop(context, "Please enter new target.", AppColors.red, Colors.white);
    }
  }

  exitTrade({
    required BuildContext context,
    required String ltp,
    required String tradeId,
  }) {
    var data = {"closingPrice": ltp};
    Networking()
        .postParams(
      context: context,
      mapData: data,
      endPoint: AppApiEndPoint.position,
      isLoaderShow: true,
      params: "/$tradeId/close",
      fromBottomSheet: false,
    )
        .then(
      (value) {
        if (value != null) {
          UpdateTargetModel updateTargetModel = UpdateTargetModel.fromJson(value);
          AppWidget().snackBarTop(context, updateTargetModel.message ?? "", AppColors.green, Colors.white);
          newStopLossController.clear();
          Navigator.pop(context, true);
        }
      },
    );
  }
}
