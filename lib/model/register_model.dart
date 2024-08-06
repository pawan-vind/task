// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
    bool? status;
    String? message;
    Data? data;

    RegisterModel({
        this.status,
        this.message,
        this.data,
    });

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    String? email;
    String? token;

    Data({
        this.id,
        this.email,
        this.token,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "token": token,
    };
}
