import 'dart:convert';

import 'package:dhanraj/model/login_model.dart';
import 'package:dhanraj/pages/dashboard/history.dart';
import 'package:dhanraj/pages/dashboard/position.dart';
import 'package:dhanraj/pages/dashboard/settings.dart';
import 'package:dhanraj/pages/dashboard/watchlist.dart';
import 'package:dhanraj/provider/provider_watchlist.dart';
import 'package:dhanraj/provider/web_socket_service.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/preference_key.dart';

class ProviderDashboard extends ChangeNotifier {
  int currentIndex = 0;
  String title = AppStrings.watchlist;
  SharedPreferences? sp;
  LoginModel? loginModel;
  String? customerInitial;

  List<Widget> pages = [
    Watchlist(key: UniqueKey()),
    const Position(),
    const History(),
    const Settings(),
  ];

  getPrefData() async {
    currentIndex = 0;
    sp = await SharedPreferences.getInstance();
    String data = sp?.getString(PreferenceKey.loginData) ?? "";

    loginModel = LoginModel.fromJson(jsonDecode(data));

    customerInitial = loginModel?.result?.user?.userName?[0];
    notifyListeners();
  }

  changePages({required int val, required BuildContext context}) {
    if (Provider.of<ProviderWatchlist>(context, listen: false).selectedWatchList?.watchlistId.toString() != null) {
      Provider.of<WebSocketService>(context, listen: false).unsubscribeFromWatchlist(
        int.parse(
          Provider.of<ProviderWatchlist>(context, listen: false).selectedWatchList?.watchlistId.toString() ?? "",
        ),
      );
    }

    setTitle(val: val);
    currentIndex = val;
    notifyListeners();
  }

  setTitle({required int val}) {
    switch (val) {
      case 0:
        title = AppStrings.watchlist;
        break;
      case 1:
        title = AppStrings.position;
        break;
      case 2:
        title = AppStrings.history;
        break;
      case 3:
        title = AppStrings.settings;
        break;
    }
    notifyListeners();
  }
}
