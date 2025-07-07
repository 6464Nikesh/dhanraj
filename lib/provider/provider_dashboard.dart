import 'package:dhanraj/pages/dashboard/history.dart';
import 'package:dhanraj/pages/dashboard/position.dart';
import 'package:dhanraj/pages/dashboard/settings.dart';
import 'package:dhanraj/pages/dashboard/watchlist.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/web_socket_service.dart';
import '../utils/preference_key.dart';

class ProviderDashboard extends ChangeNotifier {
  int currentIndex = 0;
  String title = AppStrings.watchlist;
  SharedPreferences? sp;

  List<Widget> pages = [
    const Watchlist(),
    const Position(),
    const History(),
    const Settings(),
  ];

  init({required BuildContext context}) async {
    sp = await SharedPreferences.getInstance();
    String token = sp?.getString(PreferenceKey.token).toString() ?? "";
    Provider.of<WebSocketService>(context, listen: false).connect(token);
  }

  logOut(BuildContext context) async {
    sp = await SharedPreferences.getInstance();
    sp?.clear();
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (Route<dynamic> route) => false);
  }

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
