import 'package:dhanraj/model/get_watchlist_items_model.dart';

class MarginModel {
  String? status;
  int? statusCode;
  String? message;
  Result? result;
  List<Errors>? errors;

  MarginModel(
      {this.status, this.statusCode, this.message, this.result, this.errors});

  MarginModel.fromJson(Map<String, dynamic> json) {
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
  num? margin;
  MarginData? marginData;
  num? leverage;

  Result({this.margin, this.marginData, this.leverage});

  Result.fromJson(Map<String, dynamic> json) {
    margin = json['margin'];
    marginData = json['marginData'] != null
        ? new MarginData.fromJson(json['marginData'])
        : null;
    leverage = json['leverage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['margin'] = this.margin;
    if (this.marginData != null) {
      data['marginData'] = this.marginData!.toJson();
    }
    data['leverage'] = this.leverage;
    return data;
  }
}

class MarginData {
  String? type;
  String? tradingsymbol;
  String? exchange;
  Charges? charges;
  num? total;

  MarginData(
      {this.type, this.tradingsymbol, this.exchange, this.charges, this.total});

  MarginData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    tradingsymbol = json['tradingsymbol'];
    exchange = json['exchange'];
    charges =
    json['charges'] != null ? new Charges.fromJson(json['charges']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['tradingsymbol'] = this.tradingsymbol;
    data['exchange'] = this.exchange;
    if (this.charges != null) {
      data['charges'] = this.charges!.toJson();
    }
    data['total'] = this.total;
    return data;
  }
}

class Charges {
  num? transactionTax;
  String? transactionTaxType;
  num? exchangeTurnoverCharge;
  num? sebiTurnoverCharge;
  num? brokerage;
  num? stampDuty;
  Gst? gst;
  num? total;

  Charges(
      {this.transactionTax,
        this.transactionTaxType,
        this.exchangeTurnoverCharge,
        this.sebiTurnoverCharge,
        this.brokerage,
        this.stampDuty,
        this.gst,
        this.total});

  Charges.fromJson(Map<String, dynamic> json) {
    transactionTax = json['transaction_tax'];
    transactionTaxType = json['transaction_tax_type'];
    exchangeTurnoverCharge = json['exchange_turnover_charge'];
    sebiTurnoverCharge = json['sebi_turnover_charge'];
    brokerage = json['brokerage'];
    stampDuty = json['stamp_duty'];
    gst = json['gst'] != null ? new Gst.fromJson(json['gst']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_tax'] = this.transactionTax;
    data['transaction_tax_type'] = this.transactionTaxType;
    data['exchange_turnover_charge'] = this.exchangeTurnoverCharge;
    data['sebi_turnover_charge'] = this.sebiTurnoverCharge;
    data['brokerage'] = this.brokerage;
    data['stamp_duty'] = this.stampDuty;
    if (this.gst != null) {
      data['gst'] = this.gst!.toJson();
    }
    data['total'] = this.total;
    return data;
  }
}

class Gst {
  num? igst;
  num? cgst;
  num? sgst;
  num? total;

  Gst({this.igst, this.cgst, this.sgst, this.total});

  Gst.fromJson(Map<String, dynamic> json) {
    igst = json['igst'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['igst'] = this.igst;
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    data['total'] = this.total;
    return data;
  }
}
