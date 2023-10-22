// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class AdminRequestModel {
  String? name;
  String? mail;
  bool? enabled;
  bool? super_admin;
  String? firebase_uid;

  AdminRequestModel({
    this.name,
    this.mail,
    this.enabled = true,
    this.super_admin = false,
    this.firebase_uid,
  });

  factory AdminRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AdminRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminRequestModelToJson(this);
}

@JsonSerializable()
class AdminModel {
  int? id;
  String? name;
  String? mail;
  bool? enabled;
  bool? super_admin;
  String? firebase_uid;
  String? time_create;

  AdminModel({
    this.id,
    this.name,
    this.mail,
    this.enabled,
    this.super_admin,
    this.firebase_uid,
    this.time_create ,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) =>
      _$AdminModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminModelToJson(this);
}
