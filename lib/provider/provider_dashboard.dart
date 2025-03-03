import 'package:dhanraj/pages/dashboard/history.dart';
import 'package:dhanraj/pages/dashboard/position.dart';
import 'package:dhanraj/pages/dashboard/settings.dart';
import 'package:dhanraj/pages/dashboard/watchlist.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/cupertino.dart';

class ProviderDashboard extends ChangeNotifier {
  int currentIndex = 0;
  String title = AppStrings.watchlist;

  List<Widget> pages = [
    const Watchlist(),
    const Position(),
    const History(),
    const Settings(),
  ];

  changePages({required int val}) {
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
