class LoginModel {
  String? status;
  int? statusCode;
  String? message;
  Result? result;
  List<Errors>? errors;

  LoginModel({this.status, this.statusCode, this.message, this.result, this.errors});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  User? user;
  String? token;
  int? expiresIn;
  String? tokenType;
  String? expiryTime;

  Result({this.user, this.token, this.expiresIn, this.tokenType, this.expiryTime});

  Result.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    expiresIn = json['expiresIn'];
    tokenType = json['tokenType'];
    expiryTime = json['expiryTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    data['expiresIn'] = expiresIn;
    data['tokenType'] = tokenType;
    data['expiryTime'] = expiryTime;
    return data;
  }
}

class User {
  int? userId;
  String? userName;
  String? emailId;
  String? firstName;
  String? lastName;
  String? roleType;
  String? accountStatus;

  User({this.userId, this.userName, this.emailId, this.firstName, this.lastName, this.roleType, this.accountStatus});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    emailId = json['email_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    roleType = json['role_type'];
    accountStatus = json['account_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['email_id'] = emailId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['role_type'] = roleType;
    data['account_status'] = accountStatus;
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
    data['field'] = this.field;
    data['message'] = this.message;
    return data;
  }
}
