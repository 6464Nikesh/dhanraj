import 'package:dhanraj/model/get_watchlist_items_model.dart';

class ChangePasswordModel {
  String? status;
  int? statusCode;
  String? message;
  Result? result;
  List<Errors>? errors;

  ChangePasswordModel(
      {this.status, this.statusCode, this.message, this.result, this.errors});

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? newPassword;

  Result({this.userId, this.newPassword});

  Result.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    newPassword = json['new_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['new_password'] = this.newPassword;
    return data;
  }
}
