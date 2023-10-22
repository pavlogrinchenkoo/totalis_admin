// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class UserRequestModel {
  String? first_name;
  String? last_name;
  String? firebase_uid;
  String? avatar;
  bool? is_tester;
  String? sex;
  String? birth;
  int? coach_id;

  UserRequestModel({
    this.first_name,
    this.last_name,
    this.firebase_uid,
    this.avatar,
    this.is_tester,
    this.sex,
    this.birth,
    this.coach_id,
  });

  factory UserRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UserRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestModelToJson(this);
}

@JsonSerializable()
class UserModel {
  int? id;
  String? first_name;
  String? last_name;
  String? firebase_uid;
  String? avatar;
  bool? is_tester;
  String? sex;
  String? birth;
  int? coach_id;
  String? time_create;

  UserModel({
    this.id,
    this.first_name,
    this.last_name,
    this.firebase_uid,
    this.avatar,
    this.is_tester,
    this.sex,
    this.birth,
    this.coach_id,
    this.time_create,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
