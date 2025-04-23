class AppApiEndPoint {
  static const String baseUrl = "http://3.111.59.182/api/v1/";
  static const String loginUser = "auth-service/login-user";
  static const String getAllSymbols = "trading-symbol-service/get-all-symbols";
  static const String addWatchListItems = "watchlist-item-service/add-watchlist-item";
  static const String allWatchList = "watch-list-service/list";
  static const String createWatchList = "watch-list-service/create";
  static const String getWatchListItems = "watchlist-item-service/get-watchlist-items";
  static const String itemRemove = "watchlist-item-service/remove";

  static const String addFunds = "transaction-service/add-funds";
  static const String withdrawalRequest = "transaction-service/withdrawal-request";
}
