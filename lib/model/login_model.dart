import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    bool? status;
    String? message;
    Record? record;

    LoginModel({
        this.status,
        this.message,
        this.record,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        record: json["record"] == null ? null : Record.fromJson(json["record"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "record": record?.toJson(),
    };
}

class Record {
    int? id;
    String? firstName;
    String? lastName;
    String? email;
    String? phoneNo;
    String? profileImg;
    String? authtoken;

    Record({
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNo,
        this.profileImg,
        this.authtoken,
    });

    factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNo: json["phoneNo"],
        profileImg: json["profileImg"],
        authtoken: json["authtoken"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNo": phoneNo,
        "profileImg": profileImg,
        "authtoken": authtoken,
    };
}
