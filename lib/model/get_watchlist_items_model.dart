class GetWatchlistItemsModel {
  String? status;
  int? statusCode;
  String? message;
  Result? result;
  List<Errors>? errors;

  GetWatchlistItemsModel({this.status, this.statusCode, this.message, this.result, this.errors});

  GetWatchlistItemsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  List<Items>? items;
  Pagination? pagination;

  Result({this.items, this.pagination});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Items {
  String? watchlistItemId;
  String? watchlistId;
  String? symbolId;
  int? sortOrder;
  String? alertHigh;
  String? alertLow;
  String? customNotes;
  bool? isFavorite;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  Symbol? symbol;
  Watchlist? watchlist;

  Items(
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
      this.symbol,
      this.watchlist});

  Items.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    symbol = json['symbol'] != null ? Symbol.fromJson(json['symbol']) : null;
    watchlist = json['watchlist'] != null ? Watchlist.fromJson(json['watchlist']) : null;
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
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (symbol != null) {
      data['symbol'] = symbol!.toJson();
    }
    if (watchlist != null) {
      data['watchlist'] = watchlist!.toJson();
    }
    return data;
  }
}

class Symbol {
  String? symbolId;
  String? strike;
  String? instrumentToken;
  String? tradingsymbol;
  String? name;
  String? lastPrice;
  String? exchange;
  String? segment;
  String? instrumentType;
  String? expiry;
  num? lotSize;

  Symbol({
    this.symbolId,
    this.strike,
    this.instrumentToken,
    this.tradingsymbol,
    this.name,
    this.lastPrice,
    this.exchange,
    this.segment,
    this.instrumentType,
    this.expiry,
    this.lotSize,
  });

  Symbol.fromJson(Map<String, dynamic> json) {
    symbolId = json['symbol_id'];
    instrumentToken = json['instrument_token'];
    tradingsymbol = json['tradingsymbol'];
    name = json['name'];
    strike = json['strike'];
    lastPrice = json['last_price'];
    exchange = json['exchange'];
    segment = json['segment'];
    instrumentType = json['instrument_type'];
    expiry = json['expiry'];
    lotSize = json['lot_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol_id'] = symbolId;
    data['strike'] = strike;
    data['tradingsymbol'] = tradingsymbol;
    data['instrument_token'] = instrumentToken;
    data['name'] = name;
    data['last_price'] = lastPrice;
    data['exchange'] = exchange;
    data['segment'] = segment;
    data['instrument_type'] = instrumentType;
    data['expiry'] = expiry;
    data['lot_size'] = lotSize;
    return data;
  }
}

class Watchlist {
  String? watchlistId;
  String? watchlistName;

  Watchlist({this.watchlistId, this.watchlistName});

  Watchlist.fromJson(Map<String, dynamic> json) {
    watchlistId = json['watchlist_id'];
    watchlistName = json['watchlist_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['watchlist_id'] = watchlistId;
    data['watchlist_name'] = watchlistName;
    return data;
  }
}

class Pagination {
  int? total;
  int? currentPage;
  int? perPage;
  int? totalPages;

  Pagination({this.total, this.currentPage, this.perPage, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    currentPage = json['current_page'];
    perPage = json['per_page'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['current_page'] = currentPage;
    data['per_page'] = perPage;
    data['total_pages'] = totalPages;
    return data;
  }
}

class Errors {
  String? field;
  String? message;

  Errors({this.field, this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['field'] = field;
    data['message'] = message;
    return data;
  }
}
