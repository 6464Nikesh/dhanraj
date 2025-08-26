import 'dart:convert';

import 'package:dhanraj/model/get_watchlist_items_model.dart';
import 'package:dhanraj/model/watchlists_model.dart';
import 'package:dhanraj/pages/bottom_sheet/create_watchlists_model.dart';
import 'package:dhanraj/provider/web_socket_service.dart';
import 'package:dhanraj/services/networking.dart';
import 'package:dhanraj/utils/app_api_end_point.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/update_checker.dart';

class ProviderWatchlist extends ChangeNotifier {
  List<WatchLists>? watchLists = [];
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  List<Items>? items = [];
  WatchLists? selectedWatchList;

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
      value = " ${value.replaceFirst(RegExp(r'\.0+$'), '')}";
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
            if (selectedWatchList == null) {
              if (watchLists?.isNotEmpty ?? false) {
                selSelectedWatchList(selectedWatchList: watchLists?.first, context: context);
              }
            }
            notifyListeners();
          }
        }
      },
    );
  }

  Future<void> deleteWatchList({required BuildContext context}) async {
    await Networking().delete(context: context, endPoint: AppApiEndPoint.removeWatchlist, id: selectedWatchList?.watchlistId ?? "", isLoaderShow: true).then(
      (value) {
        selectedWatchList = null;
        watchLists?.clear();
        items?.clear();
        notifyListeners();
      },
    );
  }

  selSelectedWatchList({required WatchLists? selectedWatchList, required BuildContext context}) {
    this.selectedWatchList = selectedWatchList;
    getSymbolsList(context: context);
    notifyListeners();
  }

  Future<void> getSymbolsList({required BuildContext context}) async {
    final webSocketService = Provider.of<WebSocketService>(context, listen: false);
    webSocketService.connect(context: context);
    await Networking()
        .getWithParams(context: context, endPoint: AppApiEndPoint.getWatchListItems, isShowLoader: true, params: '?watchlist_id=${selectedWatchList?.watchlistId}')
        .then(
      (value) {
        if (value != null) {
          GetWatchlistItemsModel getWatchlistItemsModel = GetWatchlistItemsModel.fromJson(value);
          if (getWatchlistItemsModel.statusCode == 200) {
            items = getWatchlistItemsModel.result?.items ?? [];
            final watchlistId = selectedWatchList?.watchlistId?.toString();
            if (watchlistId != null) {
              webSocketService.subscribeToWatchlist(
                int.parse(watchlistId),
              );
            }

            //UpdateChecker.checkForUpdate(context);
          }
        }
      },
    );
    notifyListeners();
  }

  createNewWatchList({required BuildContext context}) {
    if (name.text.isEmpty) {
      AppWidget().snackBarTop(context, "Please enter name.", AppColors.red, Colors.white);
    } else {
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
