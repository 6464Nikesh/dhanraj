class CreateWatchListsModel {
  String? status;
  int? statusCode;
  String? message;
  Result? result;
  List<Errors>? errors;

  CreateWatchListsModel({this.status, this.statusCode, this.message, this.result, this.errors});

  CreateWatchListsModel.fromJson(Map<String, dynamic> json) {
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
  String? watchlistId;
  String? watchlistName;
  String? description;
  String? category;
  bool? isDefault;
  bool? isPublic;
  String? status;
  int? favoriteCount;
  bool? isDeleted;
  PrivacySettings? privacySettings;
  bool? isArchived;
  int? sortOrder;
  int? maxSymbols;
  NotificationSettings? notificationSettings;
  String? userId;
  String? createdBy;
  String? updatedBy;
  String? updatedAt;
  String? createdAt;

  Result({
    this.watchlistId,
    this.watchlistName,
    this.description,
    this.category,
    this.isDefault,
    this.isPublic,
    this.status,
    this.favoriteCount,
    this.isDeleted,
    this.privacySettings,
    this.isArchived,
    this.sortOrder,
    this.maxSymbols,
    this.notificationSettings,
    this.userId,
    this.createdBy,
    this.updatedBy,
    this.updatedAt,
    this.createdAt,
  });

  Result.fromJson(Map<String, dynamic> json) {
    watchlistId = json['watchlist_id'];
    watchlistName = json['watchlist_name'];
    description = json['description'];
    category = json['category'];
    isDefault = json['is_default'];
    isPublic = json['is_public'];
    status = json['status'];
    favoriteCount = json['favorite_count'];
    isDeleted = json['is_deleted'];
    privacySettings = json['privacy_settings'] != null ? PrivacySettings.fromJson(json['privacy_settings']) : null;
    isArchived = json['is_archived'];
    sortOrder = json['sort_order'];
    maxSymbols = json['max_symbols'];
    notificationSettings = json['notification_settings'] != null ? NotificationSettings.fromJson(json['notification_settings']) : null;
    userId = json['user_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['watchlist_id'] = watchlistId;
    data['watchlist_name'] = watchlistName;
    data['description'] = description;
    data['category'] = category;
    data['is_default'] = isDefault;
    data['is_public'] = isPublic;
    data['status'] = status;
    data['favorite_count'] = favoriteCount;
    data['is_deleted'] = isDeleted;
    if (privacySettings != null) {
      data['privacy_settings'] = privacySettings!.toJson();
    }
    data['is_archived'] = isArchived;
    data['sort_order'] = sortOrder;
    data['max_symbols'] = maxSymbols;
    if (notificationSettings != null) {
      data['notification_settings'] = notificationSettings!.toJson();
    }
    data['user_id'] = userId;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
}

class PrivacySettings {
  String? visibility;

  PrivacySettings({this.visibility});

  PrivacySettings.fromJson(Map<String, dynamic> json) {
    visibility = json['visibility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['visibility'] = visibility;
    return data;
  }
}

class NotificationSettings {
  bool? priceAlerts;
  bool? volumeAlerts;
  bool? technicalAlerts;

  NotificationSettings({this.priceAlerts, this.volumeAlerts, this.technicalAlerts});

  NotificationSettings.fromJson(Map<String, dynamic> json) {
    priceAlerts = json['price_alerts'];
    volumeAlerts = json['volume_alerts'];
    technicalAlerts = json['technical_alerts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price_alerts'] = priceAlerts;
    data['volume_alerts'] = volumeAlerts;
    data['technical_alerts'] = technicalAlerts;
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
    data['field'] = field;
    data['message'] = message;
    return data;
  }
}
