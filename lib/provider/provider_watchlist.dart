import 'dart:convert';

import 'package:dhanraj/model/get_watchlist_items_model.dart';
import 'package:dhanraj/model/watchlists_model.dart';
import 'package:dhanraj/pages/bottom_sheet/create_watchlists_model.dart';
import 'package:dhanraj/services/networking.dart';
import 'package:dhanraj/utils/app_api_end_point.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/web_socket_service.dart';

class ProviderWatchlist extends ChangeNotifier {
  List<WatchLists>? watchLists = [];
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  List<Items>? items = [];
  WatchLists? selectedWatchList;
  final Set<int> watchlistIds = {};

  deleteWatchListItem({required BuildContext context, required String id}) {
    Networking().delete(context: context, endPoint: AppApiEndPoint.itemRemove, id: id, isLoaderShow: true).then(
      (value) {
        if (value != null) {
          Navigator.pop(context, true);
        }
      },
    );
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

  getWatchList({required BuildContext context}) {
    Networking().get(context: context, endPoint: AppApiEndPoint.allWatchList, isShowLoader: true).then(
      (value) {
        if (value != null) {
          WatchListsModel watchListsModel = WatchListsModel.fromJson(value);
          if (watchListsModel.statusCode == 200) {
            watchLists = watchListsModel.result?.watchLists ?? [];

            selSelectedWatchList(selectedWatchList: watchLists?.first, context: context);
            notifyListeners();
          }
        }
      },
    );
  }

  selSelectedWatchList({required WatchLists? selectedWatchList, required BuildContext context}) {
    print(selectedWatchList?.watchlistId);
    this.selectedWatchList = selectedWatchList;
    getSymbolsList(context: context);
    notifyListeners();
  }

  getSymbolsList({required BuildContext context}) {
    Networking().getWithParams(context: context, endPoint: AppApiEndPoint.getWatchListItems, isShowLoader: true, params: '?watchlist_id=${selectedWatchList?.watchlistId}').then(
      (value) {
        if (value != null) {
          GetWatchlistItemsModel getWatchlistItemsModel = GetWatchlistItemsModel.fromJson(value);
          if (getWatchlistItemsModel.statusCode == 200) {
            items = getWatchlistItemsModel.result?.items ?? [];
            for (var i = 0; i < (items?.length ?? 0); ++i) {
              Provider.of<WebSocketService>(context, listen: false).subscribe(int.parse(selectedWatchList?.watchlistId.toString() ?? ""));
            }
            notifyListeners();
          }
        }
      },
    );
    notifyListeners();
  }

  createNewWatchList({required BuildContext context}) {
    if (name.text.isEmpty) {
      AppWidget().snackBarTop(context, "Please enter name.", AppColors.red, Colors.white);
    }  else {
      var mapData = {"watchlist_name": name.text, "description": "DI", "category": "EQUITY"};

      Networking().post(context: context, mapData: mapData, endPoint: AppApiEndPoint.createWatchList, isLoaderShow: true, fromBottomSheet: false).then(
        (value) {
          if (value != null) {
            CreateWatchListsModel createWatchListsModel = CreateWatchListsModel.fromJson(value);
            if (createWatchListsModel.statusCode == 201) {
              name.clear();
              description.clear();
              Navigator.pop(context, true);
            }
          }
        },
      );
    }
  }
}
