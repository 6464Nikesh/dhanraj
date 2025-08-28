import 'dart:convert';

import 'package:dhanraj/provider/provider_watchlist.dart';
import 'package:dhanraj/provider/web_socket_service.dart';
import 'package:dhanraj/utils/app_assets.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/login_model.dart';
import '../utils/preference_key.dart';

class ProviderSettings extends ChangeNotifier {
  SharedPreferences? sp;
  LoginModel? loginModel;

  getPrefData() async {
    sp = await SharedPreferences.getInstance();
    String data = sp?.getString(PreferenceKey.loginData) ?? "";

    if (data.isNotEmpty) {
      loginModel = LoginModel.fromJson(jsonDecode(data));
    }

    notifyListeners();
  }

  String getServerName({required String userName}) {
    if (userName.startsWith("NC")) {
      return "Nesta";
    } else if (userName.startsWith("DC")) {
      return "Dhanraj";
    }

    return "";
  }

  String getCompanyName({required String userName}) {
    if (userName.startsWith("NC")) {
      return "Nesta Capital";
    } else if (userName.startsWith("DC")) {
      return "Dhanraj Trading";
    }

    return "";
  }

  String getCompanyLogo({required String userName}) {
    if (userName.startsWith("NC")) {
      return AppAssets.nestaTrading;
    } else if (userName.startsWith("DC")) {
      return AppAssets.logo;
    }

    return "";
  }

  navigate({required BuildContext context}) async {
    final url = Theme.of(context).platform == TargetPlatform.iOS
        ? "https://apps.apple.com/in/app/Dhanraj-Trading/id6749827410"
        : "https://play.google.com/store/apps/details?id=dhanraj.trading";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  logOut(BuildContext context) async {
    sp = await SharedPreferences.getInstance();
    sp?.clear();
    Provider.of<ProviderWatchlist>(context, listen: false).clear();
    Provider.of<WebSocketService>(context, listen: false).disconnect();
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (Route<dynamic> route) => false);
  }
}
