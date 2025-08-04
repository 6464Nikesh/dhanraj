import 'package:dhanraj/model/position_model.dart';
import 'package:dhanraj/provider/position_provider.dart';
import 'package:dhanraj/services/networking.dart';
import 'package:dhanraj/utils/app_api_end_point.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderHistory extends ChangeNotifier {
  List<Trades> trades = [];
  num totalBrokerage = 0;
  num realisedPnl = 0;
  num netPnl = 0;

  String removeTrailingZeros(String value) {
    double val = double.tryParse(value) ?? 0.0;

    if (val == 0) return '';
    if (value.contains('.')) {
      // Remove trailing zeros and dot if nothing remains after dot
      value = " ${value.replaceFirst(RegExp(r'\.0+$'), '')}"; // e.g., 12.0000 -> 12
    }
    return value;
  }

  calculatePnl(num val) {
    realisedPnl = realisedPnl + val;
  }

  Future<void> fetchSymbols({required BuildContext context}) async {
    trades.clear();
    String urlParams = '?page=1&limit=1000&status=CLOSED';

    await Networking()
        .getWithParams(
      context: context,
      endPoint: AppApiEndPoint.position,
      isShowLoader: false,
      params: urlParams,
    )
        .then((response) {
      if (response != null) {
        totalBrokerage = 0;
        realisedPnl = 0;

        PositionModel positionModel = PositionModel.fromJson(response);
        trades = positionModel.result?.trades ?? [];

        for (var i = 0; i < trades.length; ++i) {
          final trade = trades[i];

          // Brokerage
          totalBrokerage += num.tryParse(trade.brokerage.toString()) ?? 0;

          // Calculate P&L
          final multiplier = Provider.of<PositionProvider>(context, listen: false).commodityMultipliers[trade.symbolName] ?? 1;
          final open = num.tryParse(trade.openPrice ?? '0') ?? 0;
          final close = num.tryParse(trade.closePrice ?? '0') ?? 0;
          final qty = trade.quantity ?? 0;
          final isBuy = trade.tradeType?.toUpperCase() == 'BUY';

          final pnl = isBuy ? (close - open) * qty * multiplier : (open - close) * qty * multiplier;
          realisedPnl += pnl;
        }

        netPnl = realisedPnl - totalBrokerage;
        notifyListeners();
      }
    });
  }
}
