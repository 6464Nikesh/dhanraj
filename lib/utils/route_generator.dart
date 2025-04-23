import 'package:dhanraj/arguments/global_search_arg.dart';
import 'package:dhanraj/pages/auth/login.dart';
import 'package:dhanraj/pages/auth/sign_up.dart';
import 'package:dhanraj/pages/dashboard.dart';
import 'package:dhanraj/pages/history/history_trade_details.dart';
import 'package:dhanraj/pages/position/modify_target.dart';
import 'package:dhanraj/pages/position/trade_details.dart';
import 'package:dhanraj/pages/splash.dart';
import 'package:dhanraj/pages/settings/change_password.dart';
import 'package:dhanraj/pages/settings/funds.dart';
import 'package:dhanraj/pages/settings/profile.dart';
import 'package:dhanraj/pages/settings/trading_terms.dart';
import 'package:dhanraj/pages/watchlist/global_search.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return buildRoute(const Splash(), settings: settings);
      case AppRoutes.login:
        return buildRoute(const Login(), settings: settings);
      case AppRoutes.signUp:
        return buildRoute(const SignUp(), settings: settings);
      case AppRoutes.dashboard:
        return buildRoute(const Dashboard(), settings: settings);
      case AppRoutes.profile:
        return buildRoute(const Profile(), settings: settings);
      case AppRoutes.tradingTerms:
        return buildRoute(const TradingTerms(), settings: settings);
      case AppRoutes.changePassword:
        return buildRoute(const ChangePassword(), settings: settings);
      case AppRoutes.funds:
        return buildRoute(const Funds(), settings: settings);
      case AppRoutes.tradeDetails:
        return buildRoute(const TradeDetails(), settings: settings);
      case AppRoutes.modifyTarget:
        return buildRoute(const ModifyTarget(), settings: settings);
      case AppRoutes.historyTradeDetails:
        return buildRoute(const HistoryTradeDetails(), settings: settings);
      case AppRoutes.globalSearch:
        final arguments = settings.arguments as GlobalSearchArg;
        return buildRoute(GlobalSearch(globalSearchArg: arguments), settings: settings);
      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute buildRoute(Widget child, {required RouteSettings settings}) {
    return MaterialPageRoute(settings: settings, builder: (BuildContext context) => child);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(
                'Seems the route you\'ve navigated to doesn\'t exist!!',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    });
  }
}
