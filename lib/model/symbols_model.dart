// To parse this JSON data, do
//
//     final symbolsModel = symbolsModelFromJson(jsonString);

import 'dart:convert';

SymbolsModel symbolsModelFromJson(String str) => SymbolsModel.fromJson(json.decode(str));

String symbolsModelToJson(SymbolsModel data) => json.encode(data.toJson());

class SymbolsModel {
  String? status;
  int? statusCode;
  String? message;
  Result? result;
  List<dynamic>? errors;

  SymbolsModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
    this.errors,
  });

  factory SymbolsModel.fromJson(Map<String, dynamic> json) => SymbolsModel(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        result: Result.fromJson(json["result"]),
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
        "result": result?.toJson(),
        "errors": List<dynamic>.from(errors?.map((x) => x) ?? []),
      };
}

class Result {
  List<Symbol>? symbols;
  Pagination? pagination;
  List<Statistic>? statistics;
  Filters? filters;

  Result({
    this.symbols,
    this.pagination,
    this.statistics,
    this.filters,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        symbols: List<Symbol>.from(json["symbols"].map((x) => Symbol.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        statistics: List<Statistic>.from(json["statistics"].map((x) => Statistic.fromJson(x))),
        filters: Filters.fromJson(json["filters"]),
      );

  Map<String, dynamic> toJson() => {
        "symbols": List<dynamic>.from(symbols?.map((x) => x.toJson()) ?? []),
        "pagination": pagination?.toJson(),
        "statistics": List<dynamic>.from(statistics?.map((x) => x.toJson()) ?? []),
        "filters": filters?.toJson(),
      };
}

class Filters {
  int? applied;
  Conditions? conditions;

  Filters({
    this.applied,
    this.conditions,
  });

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        applied: json["applied"],
        conditions: Conditions.fromJson(json["conditions"]),
      );

  Map<String, dynamic> toJson() => {
        "applied": applied,
        "conditions": conditions?.toJson(),
      };
}

class Conditions {
  Conditions();

  factory Conditions.fromJson(Map<String, dynamic> json) => Conditions();

  Map<String, dynamic> toJson() => {};
}

class Pagination {
  int? total;
  int? currentPage;
  int? perPage;
  int? totalPages;
  bool? hasNext;
  bool? hasPrevious;

  Pagination({
    this.total,
    this.currentPage,
    this.perPage,
    this.totalPages,
    this.hasNext,
    this.hasPrevious,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        currentPage: json["current_page"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
        hasNext: json["has_next"],
        hasPrevious: json["has_previous"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "current_page": currentPage,
        "per_page": perPage,
        "total_pages": totalPages,
        "has_next": hasNext,
        "has_previous": hasPrevious,
      };
}

class Statistic {
  String? exchange;
  String? segment;
  String? instrumentType;
  String? count;
  String? avgStrike;
  String? minPrice;
  String? maxPrice;

  Statistic({
    this.exchange,
    this.segment,
    this.instrumentType,
    this.count,
    this.avgStrike,
    this.minPrice,
    this.maxPrice,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) => Statistic(
        exchange: json["exchange"],
        segment: json["segment"],
        instrumentType: json["instrument_type"],
        count: json["count"],
        avgStrike: json["avg_strike"],
        minPrice: json["min_price"],
        maxPrice: json["max_price"],
      );

  Map<String, dynamic> toJson() => {
        "exchange": exchange,
        "segment": segment,
        "instrument_type": instrumentType,
        "count": count,
        "avg_strike": avgStrike,
        "min_price": minPrice,
        "max_price": maxPrice,
      };
}

class Symbol {
  String? symbolId;
  bool? isSelected = false;
  String? tradingsymbol;
  String? name;
  String? lastPrice;
  String? exchange;
  String? segment;
  String? instrumentType;
  String? expiry;
  String? strike;
  String? tickSize;
  num? lotSize;
  bool? isActive;
  String? createdBy;
  String? createdAt;
  Creator? creator;

  Symbol({
    this.isSelected,
    this.symbolId,
    this.tradingsymbol,
    this.name,
    this.lastPrice,
    this.exchange,
    this.segment,
    this.instrumentType,
    this.expiry,
    this.strike,
    this.tickSize,
    this.lotSize,
    this.isActive,
    this.createdBy,
    this.createdAt,
    this.creator,
  });

  factory Symbol.fromJson(Map<String, dynamic> json) => Symbol(
        symbolId: json["symbol_id"],
        tradingsymbol: json["tradingsymbol"],
        name: json["name"],
        lastPrice: json["last_price"],
        exchange: json["exchange"],
        segment: json["segment"],
        instrumentType: json["instrument_type"],
        expiry: json["expiry"],
        strike: json["strike"],
        tickSize: json["tick_size"],
        lotSize: json["lot_size"],
        isActive: json["is_active"],
        createdBy: json["created_by"],
        createdAt: json["created_at"],
        creator: Creator.fromJson(json["creator"]),
      );

  Map<String, dynamic> toJson() => {
        "symbol_id": symbolId,
        "tradingsymbol": tradingsymbol,
        "name": name,
        "last_price": lastPrice,
        "exchange": exchange,
        "segment": segment,
        "instrument_type": instrumentType,
        "expiry": expiry,
        "strike": strike,
        "tick_size": tickSize,
        "lot_size": lotSize,
        "is_active": isActive,
        "created_by": createdBy,
        "created_at": createdAt,
        "creator": creator?.toJson(),
      };
}

class Creator {
  int? userId;
  String? userName;
  String? firstName;
  String? lastName;

  Creator({
    this.userId,
    this.userName,
    this.firstName,
    this.lastName,
  });

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
        userId: json["user_id"],
        userName: json["user_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "first_name": firstName,
        "last_name": lastName,
      };
}
