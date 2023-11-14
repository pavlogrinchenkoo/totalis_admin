// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class CategoryModelRequest {
  int? parent_id;
  String? name;
  int? icon_id;
  int? sort_order;
  String? description;
  bool? is_home;
  String? subcategories_title;
  bool? show_checkin_history;
  bool? checkin_enabled;
  String? guidelines_file_link;
  String? prompt;
  String? prompt_checkin;
  String? prompt_checkin_proposal;
  String? prompt_followup;
  bool? followup_chat_enabled;
  int? followup_timer;

  CategoryModelRequest({
    this.parent_id,
    this.name,
    this.icon_id,
    this.sort_order,
    this.description,
    this.is_home,
    this.subcategories_title,
    this.show_checkin_history,
    this.checkin_enabled,
    this.guidelines_file_link,
    this.prompt,
    this.prompt_checkin,
    this.prompt_checkin_proposal,
    this.prompt_followup,
    this.followup_chat_enabled,
    this.followup_timer,
  });

  factory CategoryModelRequest.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelRequestToJson(this);
}

@JsonSerializable()
class CategoryModel {
  int? parent_id;
  String? name;
  int? icon_id;
  int? sort_order;
  String? description;
  bool? is_home;
  String? subcategories_title;
  bool? show_checkin_history;
  bool? checkin_enabled;
  String? guidelines_file_link;
  String? prompt;
  String? prompt_checkin;
  String? prompt_checkin_proposal;
  String? prompt_followup;
  bool? followup_chat_enabled;
  int? followup_timer;
  int? id;
  String? time_create;

  CategoryModel({
    this.parent_id,
    this.name,
    this.icon_id,
    this.sort_order,
    this.description,
    this.is_home,
    this.subcategories_title,
    this.show_checkin_history,
    this.checkin_enabled,
    this.guidelines_file_link,
    this.prompt,
    this.prompt_checkin,
    this.prompt_checkin_proposal,
    this.prompt_followup,
    this.followup_chat_enabled,
    this.followup_timer,
    this.id,
    this.time_create,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
