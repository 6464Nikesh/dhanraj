import 'package:dhanraj/model/add_watch_list_items_model.dart';
import 'package:dhanraj/model/symbols_model.dart' as symbol;
import 'package:dhanraj/provider/provider_watchlist.dart';
import 'package:dhanraj/services/networking.dart';
import 'package:dhanraj/utils/app_api_end_point.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderGlobalSearch extends ChangeNotifier {
  List<symbol.Symbol> symbolsList = [];
  TextEditingController searchController = TextEditingController();

  clear() {
    searchController.clear();
    symbolsList.clear();
    notifyListeners();
  }

  setSelectedSymbols({required int index, required bool val}) {
    symbolsList[index].isSelected = val;
    notifyListeners();
  }

  addSymbolsInWatchList({required String watchlistId, required symbol.Symbol s, required BuildContext context}) {
    var map = {
      "watchlist_id": watchlistId,
      "symbol_id": s.symbolId,
      "alert_high": 500.50,
      "alert_low": 450.25,
      "custom_notes": "Important stock",
      "is_favorite": true,
    };

    Networking().post(context: context, mapData: map, endPoint: AppApiEndPoint.addWatchListItems, isLoaderShow: true, fromBottomSheet: false).then(
      (value) {
        if (value != null) {
          AddWatchListItemsModel addWatchListItemsModel = AddWatchListItemsModel.fromJson(value);

          if (addWatchListItemsModel.statusCode == 201) {
            AppWidget().snackBar(context, addWatchListItemsModel.message ?? "", AppColors.green, Colors.white);
            Provider.of<ProviderWatchlist>(context, listen: false).getSymbolsList(context: context);
          }
        }
      },
    );
  }

  String removeTrailingZeros(String value) {
    double val = double.tryParse(value) ?? 0.0;

    if (val == 0) return '';
    if (value.contains('.')) {
      // Remove trailing zeros and dot if nothing remains after dot
      value = value.replaceFirst(RegExp(r'\.0+$'), ''); // e.g., 12.0000 -> 12
    }
    return value;
  }

  selectSymbols(String symbolsId, bool value) {
    for (var i = 0; i < symbolsList.length; ++i) {
      if (symbolsList[i].symbolId == symbolsId) {
        symbolsList[i].isSelected = value;
      }
    }

    notifyListeners();
  }

  getSymbols({required BuildContext context}) {
    Networking().get(context: context, endPoint: AppApiEndPoint.getAllSymbols, isShowLoader: true).then(
      (value) {
        if (value != null) {
          symbol.SymbolsModel symbolsModel = symbol.SymbolsModel.fromJson(value);
          symbolsList.addAll(symbolsModel.result?.symbols ?? []);
          notifyListeners();
        }
      },
    );
  }

  bool preSelectedItems({required BuildContext context, required String id}) {
    bool isSelected = false;
    for (var i = 0; i < (Provider.of<ProviderWatchlist>(context, listen: false).items?.length ?? 0); ++i) {
      if (id == Provider.of<ProviderWatchlist>(context, listen: false).items?[i].symbolId) {
        isSelected = true;
      }
    }
    return isSelected;
  }

  void fetchSymbols({required BuildContext context, required String search, int page = 1}) {
    symbolsList.clear();
    String urlParams = '?search=$search&page=$page';

    Networking()
        .getWithParams(
      context: context,
      endPoint: AppApiEndPoint.getAllSymbols,
      isShowLoader: false,
      params: urlParams,
    )
        .then((response) {
      if (response != null) {
        symbol.SymbolsModel symbolsModel = symbol.SymbolsModel.fromJson(response);
        symbolsList.addAll(symbolsModel.result?.symbols ?? []);

        for (var i = 0; i < symbolsList.length; ++i) {
          symbolsList[i].isSelected = preSelectedItems(context: context, id: symbolsList[i].symbolId ?? "");
        }

        notifyListeners();
      }
    });
  }
}
