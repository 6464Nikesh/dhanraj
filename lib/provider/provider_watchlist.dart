import 'package:dhanraj/pages/watchlist/bank_nifty.dart';
import 'package:dhanraj/pages/watchlist/nifty.dart';
import 'package:flutter/material.dart';

class ProviderWatchlist extends ChangeNotifier {
  List<Widget> watchlistTab = [
    const BankNifty(),
    const Nifty(),
  ];
  int tabIndex = 0;

  changePage(int val) {
    tabIndex = val;
    notifyListeners();
  }
}
