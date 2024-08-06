// To parse this JSON data, do
//
//     final userListModel = userListModelFromJson(jsonString);

import 'dart:convert';

UserListModel userListModelFromJson(String str) => UserListModel.fromJson(json.decode(str));

String userListModelToJson(UserListModel data) => json.encode(data.toJson());

class UserListModel {
    bool? status;
    String? message;
    List<UserList>? userList;
    int? currentPage;
    int? lastPage;
    int? total;
    int? perPage;

    UserListModel({
        this.status,
        this.message,
        this.userList,
        this.currentPage,
        this.lastPage,
        this.total,
        this.perPage,
    });

    factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
        status: json["status"],
        message: json["message"],
        userList: json["userList"] == null ? [] : List<UserList>.from(json["userList"]!.map((x) => UserList.fromJson(x))),
        currentPage: json["currentPage"],
        lastPage: json["lastPage"],
        total: json["total"],
        perPage: json["perPage"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "userList": userList == null ? [] : List<dynamic>.from(userList!.map((x) => x.toJson())),
        "currentPage": currentPage,
        "lastPage": lastPage,
        "total": total,
        "perPage": perPage,
    };
}

class UserList {
    int? id;
    String? firstName;
    String? lastName;
    String? email;
    String? countryCode;
    String? phoneNo;
    String? status;

    UserList({
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.countryCode,
        this.phoneNo,
        this.status,
    });

    factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        countryCode: json["country_code"],
        phoneNo: json["phone_no"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "country_code": countryCode,
        "phone_no": phoneNo,
        "status": status,
    };
}
