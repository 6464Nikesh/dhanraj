import '../pages/bottom_sheet/create_watchlists_model.dart';

class HistoryModel {
  String? status;
  int? statusCode;
  String? message;
  Result? result;
  List<Errors>? errors;

  HistoryModel({this.status, this.statusCode, this.message, this.result, this.errors});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    result = json['result'] != null ? new Result.fromJson(json['result']) : null;
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  List<Transactions>? transactions;
  Pagination? pagination;

  Result({this.transactions, this.pagination});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Transactions {
  int? transactionId;
  String? transactionType;
  String? amount;
  String? balance;
  String? paymentMode;
  BankDetails? bankDetails;
  String? status;
  String? description;
  Null? withdrawalDetails;
  TaxDetails? taxDetails;
  String? createdAt;
  String? updatedAt;
  User? user;
  Parent? parent;
  Null? approver;

  Transactions(
      {this.transactionId,
      this.transactionType,
      this.amount,
      this.balance,
      this.paymentMode,
      this.bankDetails,
      this.status,
      this.description,
      this.withdrawalDetails,
      this.taxDetails,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.parent,
      this.approver});

  Transactions.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    transactionType = json['transaction_type'];
    amount = json['amount'];
    balance = json['balance'];
    paymentMode = json['payment_mode'];
    bankDetails = json['bank_details'] != null ? new BankDetails.fromJson(json['bank_details']) : null;
    status = json['status'];
    description = json['description'];
    withdrawalDetails = json['withdrawal_details'];
    taxDetails = json['tax_details'] != null ? new TaxDetails.fromJson(json['tax_details']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    parent = json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
    approver = json['approver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = transactionId;
    data['transaction_type'] = transactionType;
    data['amount'] = amount;
    data['balance'] = balance;
    data['payment_mode'] = paymentMode;
    if (bankDetails != null) {
      data['bank_details'] = bankDetails!.toJson();
    }
    data['status'] = status;
    data['description'] = description;
    data['withdrawal_details'] = withdrawalDetails;
    if (taxDetails != null) {
      data['tax_details'] = taxDetails!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    data['approver'] = approver;
    return data;
  }
}

class BankDetails {
  String? bankName;
  String? bankReference;

  BankDetails({this.bankName, this.bankReference});

  BankDetails.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    bankReference = json['bank_reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_name'] = bankName;
    data['bank_reference'] = bankReference;
    return data;
  }
}

class TaxDetails {
  String? taxApplied;

  TaxDetails({this.taxApplied});

  TaxDetails.fromJson(Map<String, dynamic> json) {
    taxApplied = json['tax_applied'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax_applied'] = taxApplied;
    return data;
  }
}

class User {
  int? userId;
  String? userName;
  String? fullName;
  String? email;
  String? mobile;

  User({this.userId, this.userName, this.fullName, this.email, this.mobile});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    fullName = json['full_name'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['full_name'] = fullName;
    data['email'] = email;
    data['mobile'] = mobile;
    return data;
  }
}

class Parent {
  int? userId;
  String? userName;
  String? fullName;

  Parent({this.userId, this.userName, this.fullName});

  Parent.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['full_name'] = fullName;
    return data;
  }
}

class Pagination {
  int? total;
  int? totalPages;
  int? currentPage;
  int? limit;

  Pagination({this.total, this.totalPages, this.currentPage, this.limit});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = total;
    data['total_pages'] = totalPages;
    data['current_page'] = currentPage;
    data['limit'] = limit;
    return data;
  }
}
