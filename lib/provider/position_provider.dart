import 'package:dhanraj/model/position_model.dart';
import 'package:flutter/cupertino.dart';
import '../services/networking.dart';
import '../utils/app_api_end_point.dart';

class PositionProvider extends ChangeNotifier {
  List<Trades> trades = [];

  clear() {
    trades.clear();
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

          if (positionModel.statusCode == 200) {
            trades = positionModel.result?.trades ?? [];
            notifyListeners();
          }
        }
      },
    );
  }
}
