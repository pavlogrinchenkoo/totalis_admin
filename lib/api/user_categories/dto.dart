// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class UserCategoryRequestModel {
  int? user_id;
  int? category_id;
  bool? is_favorite;
  String? muted_day;
  int? muted_for;
  String? chat_summary_long;
  String? chat_summary_short;
  bool? used_chat;
  bool? is_read;

  UserCategoryRequestModel({
    this.user_id,
    this.category_id,
    this.is_favorite = false,
    this.muted_day = '',
    this.muted_for = 0,
    this.chat_summary_long = '',
    this.chat_summary_short = '',
    this.used_chat = false,
    this.is_read  = true,
  });

  factory UserCategoryRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UserCategoryRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserCategoryRequestModelToJson(this);
}

@JsonSerializable()
class UserCategoryModel {
  int? user_id;
  int? category_id;
  bool? is_favorite;
  String? muted_day;
  int? muted_for;
  String? chat_summary_long;
  String? chat_summary_short;
  bool? used_chat;
  bool? is_read;
  int? id;
  String? time_create;

  UserCategoryModel({
    this.user_id,
    this.category_id,
    this.is_favorite,
    this.muted_day,
    this.muted_for,
    this.chat_summary_long,
    this.chat_summary_short,
    this.used_chat,
    this.is_read,
    this.id,
    this.time_create,
  });

  factory UserCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$UserCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserCategoryModelToJson(this);
}
