import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  bool? status;
  String? message;
  List<Response>? response;

  DataModel({
    required this.status,
    required this.message,
    required this.response,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        status: json["status"],
        message: json["message"],
        response: List<Response>.from(
            json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "response": List<dynamic>.from(response!.map((x) => x.toJson())),
      };
}

class Response {
  String? registrationMainId;
  String? userCode;
  String? firstName;
  String? middleName;
  String? lastName;
  String? phoneNumber;
  String? phoneCountryCode;
  String? email;
  DateTime? createdTime;

  Response({
    required this.registrationMainId,
    required this.userCode,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phoneNumber,
    required this.phoneCountryCode,
    required this.email,
    required this.createdTime,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        registrationMainId: json["registration_main_id"],
        userCode: json["user_code"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        phoneCountryCode: json["phone_country_code"],
        email: json["email"],
        createdTime: DateTime.parse(json["created_time"]),
      );

  Map<String, dynamic> toJson() => {
        "registration_main_id": registrationMainId,
        "user_code": userCode,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "phone_country_code": phoneCountryCode,
        "email": email,
        "created_time": createdTime?.toIso8601String(),
      };
}
