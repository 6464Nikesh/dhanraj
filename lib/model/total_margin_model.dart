import 'package:dhanraj/model/login_model.dart';

class TotalMarginModel {
  String? status;
  int? statusCode;
  String? message;
  Result? result;
  List<Errors>? errors;

  TotalMarginModel(
      {this.status, this.statusCode, this.message, this.result, this.errors});

  TotalMarginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(new Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  num? totalMargin;
  num? totalOpenPrice;
  num? totalRequiredMargin;
  String? latestBalance;
  num? tradeCount;

  Result(
      {this.totalMargin,
        this.totalOpenPrice,
        this.totalRequiredMargin,
        this.latestBalance,
        this.tradeCount});

  Result.fromJson(Map<String, dynamic> json) {
    totalMargin = json['totalMargin'];
    totalOpenPrice = json['totalOpenPrice'];
    totalRequiredMargin = json['totalRequiredMargin'];
    latestBalance = json['latestBalance'];
    tradeCount = json['TradeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalMargin'] = this.totalMargin;
    data['totalOpenPrice'] = this.totalOpenPrice;
    data['totalRequiredMargin'] = this.totalRequiredMargin;
    data['latestBalance'] = this.latestBalance;
    data['TradeCount'] = this.tradeCount;
    return data;
  }
}
