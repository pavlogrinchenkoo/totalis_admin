// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class MessageRequestModel {
  int? user_category_id;
  bool? is_checkin;
  int? checkin_id;
  int? coach_id;
  String? text;
  RoleEnum? role;
  int? tokens_used;
  String? gpt_version;

  MessageRequestModel({
    this.user_category_id,
    this.is_checkin,
    this.checkin_id,
    this.coach_id,
    this.text,
    this.role,
    this.tokens_used,
    this.gpt_version,
  });

  factory MessageRequestModel.fromJson(Map<String, dynamic> json) =>
      _$MessageRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageRequestModelToJson(this);
}

@JsonSerializable()
class MessageModel {
  int? user_category_id;
  bool? is_checkin;
  int? checkin_id;
  int? coach_id;
  String? text;
  RoleEnum? role;
  int? tokens_used;
  String? gpt_version;
  int? id;
  String? time_create;

  MessageModel({
    this.user_category_id,
    this.is_checkin,
    this.checkin_id,
    this.coach_id,
    this.text,
    this.role,
    this.tokens_used,
    this.gpt_version,
    this.id,
    this.time_create,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}

enum RoleEnum {
  user,
  assistant
}