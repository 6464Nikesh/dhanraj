import 'package:dhanraj/model/get_watchlist_items_model.dart';

class SignUpModel {
  String? status;
  int? statusCode;
  String? message;
  Result? result;
  List<Errors>? errors;

  SignUpModel({this.status, this.statusCode, this.message, this.result, this.errors});

  SignUpModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? userName;
  String? emailId;
  String? mobileNo;
  String? roleType;

  Result({this.userId, this.userName, this.emailId, this.mobileNo, this.roleType});

  Result.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    emailId = json['email_id'];
    mobileNo = json['mobile_no'];
    roleType = json['role_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['email_id'] = emailId;
    data['mobile_no'] = mobileNo;
    data['role_type'] = roleType;
    return data;
  }
}
