import 'package:dhanraj/model/position_model.dart';
import 'package:dhanraj/services/networking.dart';
import 'package:dhanraj/utils/app_api_end_point.dart';
import 'package:flutter/material.dart';

class ProviderHistory extends ChangeNotifier {
  List<Trades> trades = [];


  String removeTrailingZeros(String value) {
    double val = double.tryParse(value) ?? 0.0;

    if (val == 0) return '';
    if (value.contains('.')) {
      // Remove trailing zeros and dot if nothing remains after dot
      value = " ${value.replaceFirst(RegExp(r'\.0+$'), '')}"; // e.g., 12.0000 -> 12
    }
    return value;
  }

  void fetchSymbols({required BuildContext context}) {
    trades.clear();
    String urlParams = '?page=1&limit=10&status=CLOSED';

    Networking()
        .getWithParams(
      context: context,
      endPoint: AppApiEndPoint.position,
      isShowLoader: false,
      params: urlParams,
    )
        .then((response) {
      if (response != null) {
        PositionModel positionModel = PositionModel.fromJson(response);

        if (positionModel.statusCode == 200) {
          trades = positionModel.result?.trades ?? [];
          notifyListeners();
        }
      }
    });
  }
}
