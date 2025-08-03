class UpdateTargetModel {
  String? status;
  int? statusCode;
  String? message;

  List<Errors>? errors;

  UpdateTargetModel({this.status, this.statusCode, this.message, this.errors});

  UpdateTargetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];

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

    if (this.errors != null) {
      data['errors'] = this.errors!.map((v) => v.toJson()).toList();
    }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field'] = this.field;
    data['message'] = this.message;
    return data;
  }
}
