// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int statusCode;
  Data data;
  String message;
  bool success;

  UserModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        statusCode: json["statusCode"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data.toJson(),
        "message": message,
        "success": success,
      };
}

class Data {
  UserRecord userRecord;
  String token;

  Data({
    required this.userRecord,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userRecord: UserRecord.fromJson(json["userRecord"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "userRecord": userRecord.toJson(),
        "token": token,
      };
}

class UserRecord {
  String uid;
  String email;
  bool emailVerified;
  bool disabled;
  Metadata metadata;
  String tokensValidAfterTime;
  List<ProviderDatum> providerData;

  UserRecord({
    required this.uid,
    required this.email,
    required this.emailVerified,
    required this.disabled,
    required this.metadata,
    required this.tokensValidAfterTime,
    required this.providerData,
  });

  factory UserRecord.fromJson(Map<String, dynamic> json) => UserRecord(
        uid: json["uid"],
        email: json["email"],
        emailVerified: json["emailVerified"],
        disabled: json["disabled"],
        metadata: Metadata.fromJson(json["metadata"]),
        tokensValidAfterTime: json["tokensValidAfterTime"],
        providerData: List<ProviderDatum>.from(
            json["providerData"].map((x) => ProviderDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "emailVerified": emailVerified,
        "disabled": disabled,
        "metadata": metadata.toJson(),
        "tokensValidAfterTime": tokensValidAfterTime,
        "providerData": List<dynamic>.from(providerData.map((x) => x.toJson())),
      };
}

class Metadata {
  dynamic lastSignInTime;
  String creationTime;
  dynamic lastRefreshTime;

  Metadata({
    required this.lastSignInTime,
    required this.creationTime,
    required this.lastRefreshTime,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        lastSignInTime: json["lastSignInTime"],
        creationTime: json["creationTime"],
        lastRefreshTime: json["lastRefreshTime"],
      );

  Map<String, dynamic> toJson() => {
        "lastSignInTime": lastSignInTime,
        "creationTime": creationTime,
        "lastRefreshTime": lastRefreshTime,
      };
}

class ProviderDatum {
  String uid;
  String email;
  String providerId;

  ProviderDatum({
    required this.uid,
    required this.email,
    required this.providerId,
  });

  factory ProviderDatum.fromJson(Map<String, dynamic> json) => ProviderDatum(
        uid: json["uid"],
        email: json["email"],
        providerId: json["providerId"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "providerId": providerId,
      };
}
