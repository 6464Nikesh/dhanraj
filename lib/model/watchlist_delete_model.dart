// To parse this JSON data, do
//
//     final watchlistDeleteModel = watchlistDeleteModelFromJson(jsonString);

import 'dart:convert';

import 'package:dhanraj/model/get_watchlist_items_model.dart';

WatchlistDeleteModel watchlistDeleteModelFromJson(String str) => WatchlistDeleteModel.fromJson(json.decode(str));

String watchlistDeleteModelToJson(WatchlistDeleteModel data) => json.encode(data.toJson());

class WatchlistDeleteModel {
  String? status;
  int? statusCode;
  String? message;
  List<Errors>? errors;

  WatchlistDeleteModel({
    this.status,
    this.statusCode,
    this.message,
    this.errors,
  });

  factory WatchlistDeleteModel.fromJson(Map<String, dynamic> json) => WatchlistDeleteModel(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        errors: List<Errors>.from(json["errors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
        "errors": List<Errors>.from(errors?.map((x) => x) ?? []),
      };
}
