
class UserListModel {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<Data>? data;
  Support? support;

  UserListModel({this.page, this.perPage, this.total, this.totalPages, this.data, this.support});

  UserListModel.fromJson(Map<String, dynamic> json) {
    if(json["page"] is int) {
      page = json["page"];
    }
    if(json["per_page"] is int) {
      perPage = json["per_page"];
    }
    if(json["total"] is int) {
      total = json["total"];
    }
    if(json["total_pages"] is int) {
      totalPages = json["total_pages"];
    }
    if(json["data"] is List) {
      data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
    if(json["support"] is Map) {
      support = json["support"] == null ? null : Support.fromJson(json["support"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["page"] = page;
    _data["per_page"] = perPage;
    _data["total"] = total;
    _data["total_pages"] = totalPages;
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    if(support != null) {
      _data["support"] = support?.toJson();
    }
    return _data;
  }
}

class Support {
  String? url;
  String? text;

  Support({this.url, this.text});

  Support.fromJson(Map<String, dynamic> json) {
    if(json["url"] is String) {
      url = json["url"];
    }
    if(json["text"] is String) {
      text = json["text"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["url"] = url;
    _data["text"] = text;
    return _data;
  }
}

class Data {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  Data({this.id, this.email, this.firstName, this.lastName, this.avatar});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["first_name"] is String) {
      firstName = json["first_name"];
    }
    if(json["last_name"] is String) {
      lastName = json["last_name"];
    }
    if(json["avatar"] is String) {
      avatar = json["avatar"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["email"] = email;
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["avatar"] = avatar;
    return _data;
  }
}