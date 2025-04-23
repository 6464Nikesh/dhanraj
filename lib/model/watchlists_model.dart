class WatchListsModel {
  String? status;
  int? statusCode;
  String? message;
  Result? result;
  List<Errors>? errors;

  WatchListsModel({this.status, this.statusCode, this.message, this.result, this.errors});

  WatchListsModel.fromJson(Map<String, dynamic> json) {
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
  List<WatchLists>? watchLists;
  Pagination? pagination;
  Filters? filters;

  Result({this.watchLists, this.pagination, this.filters});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['watchlists'] != null) {
      watchLists = <WatchLists>[];
      json['watchlists'].forEach((v) {
        watchLists!.add(WatchLists.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
    filters = json['filters'] != null ? Filters.fromJson(json['filters']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (watchLists != null) {
      data['watchlists'] = watchLists!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (filters != null) {
      data['filters'] = filters!.toJson();
    }
    return data;
  }
}

class WatchLists {
  String? watchlistId;
  String? userId;
  String? watchlistName;
  String? description;
  String? category;
  bool? isDefault;
  bool? isPublic;
  String? status;
  String? createdBy;
  String? updatedBy;
  int? favoriteCount;
  bool? isDeleted;
  PrivacySettings? privacySettings;
  bool? isArchived;
  int? sortOrder;
  int? maxSymbols;
  NotificationSettings? notificationSettings;
  String? createdAt;
  String? updatedAt;
  Owner? owner;
  Owner? creator;

  WatchLists(
      {this.watchlistId,
      this.userId,
      this.watchlistName,
      this.description,
      this.category,
      this.isDefault,
      this.isPublic,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.favoriteCount,
      this.isDeleted,
      this.privacySettings,
      this.isArchived,
      this.sortOrder,
      this.maxSymbols,
      this.notificationSettings,
      this.createdAt,
      this.updatedAt,
      this.owner,
      this.creator});

  WatchLists.fromJson(Map<String, dynamic> json) {
    watchlistId = json['watchlist_id'];
    userId = json['user_id'];
    watchlistName = json['watchlist_name'];
    description = json['description'];
    category = json['category'];
    isDefault = json['is_default'];
    isPublic = json['is_public'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    favoriteCount = json['favorite_count'];
    isDeleted = json['is_deleted'];

    privacySettings = json['privacy_settings'] != null ? PrivacySettings.fromJson(json['privacy_settings']) : null;
    isArchived = json['is_archived'];
    sortOrder = json['sort_order'];
    maxSymbols = json['max_symbols'];
    notificationSettings = json['notification_settings'] != null ? NotificationSettings.fromJson(json['notification_settings']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    creator = json['creator'] != null ? Owner.fromJson(json['creator']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['watchlist_id'] = watchlistId;
    data['user_id'] = userId;
    data['watchlist_name'] = watchlistName;
    data['description'] = description;
    data['category'] = category;
    data['is_default'] = isDefault;
    data['is_public'] = isPublic;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;

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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    if (creator != null) {
      data['creator'] = creator!.toJson();
    }
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

class Owner {
  int? userId;
  String? userName;
  String? firstName;
  String? lastName;

  Owner({this.userId, this.userName, this.firstName, this.lastName});

  Owner.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['total_pages'] = totalPages;
    data['current_page'] = currentPage;
    data['limit'] = limit;
    return data;
  }
}

class Filters {
  String? category;
  String? status;

  Filters({this.category, this.status});

  Filters.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['status'] = status;
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
