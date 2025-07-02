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
  List<symbol.Symbol> filteredSymbolsList = [];
  TextEditingController searchController = TextEditingController();

  filter(String value) {
    filteredSymbolsList.clear();
    for (var i = 0; i < symbolsList.length; ++i) {
      if ((symbolsList[i].name?.contains(value) ?? false) || (symbolsList[i].tradingsymbol?.contains(value) ?? false)) {
        filteredSymbolsList.add(symbolsList[i]);
      }
    }
    notifyListeners();
  }

  filterClear() {
    filteredSymbolsList.clear();
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

  selectSymbols(String symbolsId, bool value) {
    for (var i = 0; i < symbolsList.length; ++i) {
      if (symbolsList[i].symbolId == symbolsId) {
        symbolsList[i].isSelected = value;
      }
    }
    for (var i = 0; i < filteredSymbolsList.length; ++i) {
      if (filteredSymbolsList[i].symbolId == symbolsId) {
        filteredSymbolsList[i].isSelected = value;
      }
    }

    notifyListeners();
  }

  getSymbols({required BuildContext context}) {
    symbolsList.clear();
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
}
