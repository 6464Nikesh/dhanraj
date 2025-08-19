import 'package:dhanraj/model/get_watchlist_items_model.dart';

class MarginModel {
  String? status;
  num? statusCode;
  String? message;
  Result? result;
  List<Errors>? errors;

  MarginModel({this.status, this.statusCode, this.message, this.result, this.errors});

  MarginModel.fromJson(Map<String, dynamic> json) {
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
  num? reqiredMargin;
  num? originalMargin;
  num? totalCharges;
  MarginData? marginData;
  num? leverage;

  Result({this.reqiredMargin, this.originalMargin, this.totalCharges, this.marginData, this.leverage});

  Result.fromJson(Map<String, dynamic> json) {
    reqiredMargin = json['reqiredMargin'];
    originalMargin = json['originalMargin'];
    totalCharges = json['totalCharges'];
    marginData = json['marginData'] != null ? MarginData.fromJson(json['marginData']) : null;
    leverage = json['leverage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reqiredMargin'] = reqiredMargin;
    data['originalMargin'] = originalMargin;
    data['totalCharges'] = totalCharges;
    if (marginData != null) {
      data['marginData'] = marginData!.toJson();
    }
    data['leverage'] = leverage;
    return data;
  }
}

class MarginData {
  String? type;
  String? tradingsymbol;
  String? exchange;
  Charges? charges;
  num? total;

  MarginData({this.type, this.tradingsymbol, this.exchange, this.charges, this.total});

  MarginData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    tradingsymbol = json['tradingsymbol'];
    exchange = json['exchange'];
    charges = json['charges'] != null ? Charges.fromJson(json['charges']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['tradingsymbol'] = tradingsymbol;
    data['exchange'] = exchange;
    if (charges != null) {
      data['charges'] = charges!.toJson();
    }
    data['total'] = total;
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

  Charges({this.transactionTax, this.transactionTaxType, this.exchangeTurnoverCharge, this.sebiTurnoverCharge, this.brokerage, this.stampDuty, this.gst, this.total});

  Charges.fromJson(Map<String, dynamic> json) {
    transactionTax = json['transaction_tax'];
    transactionTaxType = json['transaction_tax_type'];
    exchangeTurnoverCharge = json['exchange_turnover_charge'];
    sebiTurnoverCharge = json['sebi_turnover_charge'];
    brokerage = json['brokerage'];
    stampDuty = json['stamp_duty'];
    gst = json['gst'] != null ? Gst.fromJson(json['gst']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_tax'] = transactionTax;
    data['transaction_tax_type'] = transactionTaxType;
    data['exchange_turnover_charge'] = exchangeTurnoverCharge;
    data['sebi_turnover_charge'] = sebiTurnoverCharge;
    data['brokerage'] = brokerage;
    data['stamp_duty'] = stampDuty;
    if (gst != null) {
      data['gst'] = gst!.toJson();
    }
    data['total'] = total;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['igst'] = igst;
    data['cgst'] = cgst;
    data['sgst'] = sgst;
    data['total'] = total;
    return data;
  }
}
