import 'package:dhanraj/model/get_watchlist_items_model.dart';

class PositionModel {
  String? status;
  int? statusCode;
  String? message;
  Result? result;
  List<Errors>? errors;

  PositionModel(
      {this.status, this.statusCode, this.message, this.result, this.errors});

  PositionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  List<Trades>? trades;
  Pagination? pagination;
  Filters? filters;

  Result({this.trades, this.pagination, this.filters});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['trades'] != null) {
      trades = <Trades>[];
      json['trades'].forEach((v) {
        trades!.add(Trades.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    filters =
    json['filters'] != null ? Filters.fromJson(json['filters']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (trades != null) {
      data['trades'] = trades!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (filters != null) {
      data['filters'] = filters!.toJson();
    }
    return data;
  }
}

class Trades {
  int? id;
  int? symbolId;
  String? symbolName;
  String? exchange;
  String? segment;
  String? expiry;
  int? symbolLotSize;
  String? tradingsymbol;
  String? tradeType;
  num? quantity;
  String? openPrice;
  String? closePrice;
  num? requiredMargin;
  String? brokerage;
  String? profitLoss;
  String? status;
  String? orderType;
  String? validity;
  String? stoplossPrice;
  String? strike;
  String? takeprofitPrice;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? instrumentToken;
  String? instrumentType;
  Execution? execution;

  Trades(
      {this.id,
        this.symbolId,
        this.symbolName,
        this.exchange,
        this.segment,
        this.expiry,
        this.symbolLotSize,
        this.tradingsymbol,
        this.tradeType,
        this.quantity,
        this.openPrice,
        this.closePrice,
        this.requiredMargin,
        this.brokerage,
        this.profitLoss,
        this.status,
        this.orderType,
        this.validity,
        this.stoplossPrice,
        this.strike,
        this.takeprofitPrice,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.instrumentToken,
        this.instrumentType,
        this.execution});

  Trades.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbolId = json['symbol_id'];
    symbolName = json['symbol_name'];
    exchange = json['exchange'];
    segment = json['segment'];
    expiry = json['expiry'];
    symbolLotSize = json['symbol_lot_size'];
    tradingsymbol = json['tradingsymbol'];
    tradeType = json['trade_type'];
    quantity = num.parse(json['quantity'] ?? "0");
    openPrice = json['openPrice'];
    closePrice = json['close_price'];
    requiredMargin = num.parse(json['requiredMargin'] ?? "0");
    brokerage = json['brokerage'];
    profitLoss = json['profitLoss'];
    status = json['status'];
    orderType = json['order_type'];
    validity = json['validity'];
    stoplossPrice = json['stoplossPrice'];
    strike = json['strike'];
    takeprofitPrice = json['takeprofitPrice'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    instrumentToken = json['instrument_token'];
    instrumentType = json['instrument_type'];
    execution = json['execution'] != null
        ? Execution.fromJson(json['execution'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['symbol_id'] = symbolId;
    data['symbol_name'] = symbolName;
    data['exchange'] = exchange;
    data['segment'] = segment;
    data['expiry'] = expiry;
    data['symbol_lot_size'] = symbolLotSize;
    data['tradingsymbol'] = tradingsymbol;
    data['trade_type'] = tradeType;
    data['quantity'] = quantity;
    data['openPrice'] = openPrice;
    data['close_price'] = closePrice;
    data['requiredMargin'] = requiredMargin;
    data['brokerage'] = brokerage;
    data['profitLoss'] = profitLoss;
    data['status'] = status;
    data['order_type'] = orderType;
    data['validity'] = validity;
    data['stoplossPrice'] = stoplossPrice;
    data['strike'] = strike;
    data['takeprofitPrice'] = takeprofitPrice;
    data['is_deleted'] = isDeleted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['instrument_token'] = instrumentToken;
    data['instrument_type'] = instrumentType;
    if (execution != null) {
      data['execution'] = execution!.toJson();
    }
    return data;
  }
}

class Execution {
  num? executedQuantity;
  String? executedPrice;
  String? executionTime;

  Execution({this.executedQuantity, this.executedPrice, this.executionTime});

  Execution.fromJson(Map<String, dynamic> json) {
    executedQuantity = num.parse(json['executed_quantity'] ?? "0");
    executedPrice = json['executed_price'];
    executionTime = json['execution_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['executed_quantity'] = executedQuantity;
    data['executed_price'] = executedPrice;
    data['execution_time'] = executionTime;
    return data;
  }
}

class Pagination {
  int? totalItems;
  int? totalPages;
  int? currentPage;
  int? itemsPerPage;

  Pagination(
      {this.totalItems, this.totalPages, this.currentPage, this.itemsPerPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_items'] = totalItems;
    data['total_pages'] = totalPages;
    data['current_page'] = currentPage;
    data['items_per_page'] = itemsPerPage;
    return data;
  }
}

class Filters {
  Null? dateRange;
  bool? includeDeleted;

  Filters({this.dateRange, this.includeDeleted});

  Filters.fromJson(Map<String, dynamic> json) {
    dateRange = json['date_range'];
    includeDeleted = json['include_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date_range'] = dateRange;
    data['include_deleted'] = includeDeleted;
    return data;
  }
}
