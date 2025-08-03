import 'package:dhanraj/model/transaction_history_model.dart';
import 'package:dhanraj/services/networking.dart';
import 'package:dhanraj/utils/app_api_end_point.dart';
import 'package:flutter/cupertino.dart';

class ProviderFunds extends ChangeNotifier {
  int currentPage = 1;
  int totalPages = 1;
  final ScrollController scrollController = ScrollController();
  List<Transactions>? transactions = [];

  clearData() {
    scrollController.dispose();
    transactions?.clear();
    currentPage = 1;
    totalPages = 1;
  }

  getTransactionHistory(BuildContext context) {
    Networking()
        .getWithParams(
      context: context,
      endPoint: AppApiEndPoint.transactionServiceHistory,
      isShowLoader: true,
      params: '?page=1&limit=1000',
    )
        .then(
      (value) {
        if (value != null) {
          TransactionHistoryModel historyModel = TransactionHistoryModel.fromJson(value);
          transactions = historyModel.result?.transactions ?? [];
          totalPages = historyModel.result?.pagination?.totalPages ?? 1;
          currentPage++;
          notifyListeners();
        }
      },
    );
  }

}
