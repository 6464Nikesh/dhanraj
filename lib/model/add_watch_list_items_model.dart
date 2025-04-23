class AddWatchListItemsModel {
  String? status;
  int? statusCode;
  String? message;
  Result? result;

  AddWatchListItemsModel({this.status, this.statusCode, this.message, this.result});

  AddWatchListItemsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }

    return data;
  }
}

class Result {
  String? watchlistItemId;
  String? watchlistId;
  String? symbolId;
  int? sortOrder;
  String? alertHigh;
  String? alertLow;
  String? customNotes;
  bool? isFavorite;
  String? createdBy;
  Null? updatedBy;
  String? createdAt;
  String? updatedAt;
  Symbol? symbol;

  Result(
      {this.watchlistItemId,
      this.watchlistId,
      this.symbolId,
      this.sortOrder,
      this.alertHigh,
      this.alertLow,
      this.customNotes,
      this.isFavorite,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.symbol});

  Result.fromJson(Map<String, dynamic> json) {
    watchlistItemId = json['watchlist_item_id'];
    watchlistId = json['watchlist_id'];
    symbolId = json['symbol_id'];
    sortOrder = json['sort_order'];
    alertHigh = json['alert_high'];
    alertLow = json['alert_low'];
    customNotes = json['custom_notes'];
    isFavorite = json['is_favorite'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    symbol = json['symbol'] != null ? Symbol.fromJson(json['symbol']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['watchlist_item_id'] = watchlistItemId;
    data['watchlist_id'] = watchlistId;
    data['symbol_id'] = symbolId;
    data['sort_order'] = sortOrder;
    data['alert_high'] = alertHigh;
    data['alert_low'] = alertLow;
    data['custom_notes'] = customNotes;
    data['is_favorite'] = isFavorite;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (symbol != null) {
      data['symbol'] = symbol!.toJson();
    }
    return data;
  }
}

class Symbol {
  String? symbolId;
  String? tradingsymbol;
  String? name;
  String? lastPrice;
  String? exchange;
  String? segment;

  Symbol({this.symbolId, this.tradingsymbol, this.name, this.lastPrice, this.exchange, this.segment});

  Symbol.fromJson(Map<String, dynamic> json) {
    symbolId = json['symbol_id'];
    tradingsymbol = json['tradingsymbol'];
    name = json['name'];
    lastPrice = json['last_price'];
    exchange = json['exchange'];
    segment = json['segment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol_id'] = symbolId;
    data['tradingsymbol'] = tradingsymbol;
    data['name'] = name;
    data['last_price'] = lastPrice;
    data['exchange'] = exchange;
    data['segment'] = segment;
    return data;
  }
}
