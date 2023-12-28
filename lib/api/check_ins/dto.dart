// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class CheckInRequestModel {
  int? user_category_id;
  String? date;
  double? level;
  String? summary;
  String? full_text;

  CheckInRequestModel({
    this.user_category_id,
    this.date,
    this.level,
    this.summary,
    this.full_text,
  });

  factory CheckInRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CheckInRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInRequestModelToJson(this);
}

@JsonSerializable()
class CheckInModel {
  int? user_category_id;
  String? date;
  double? level;
  String? summary;
  String? full_text;
  int? id;
  String? time_create;

  CheckInModel({
    this.user_category_id,
    this.date,
    this.level,
    this.summary,
    this.full_text,
    this.id,
    this.time_create,
  });

  factory CheckInModel.fromJson(Map<String, dynamic> json) =>
      _$CheckInModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInModelToJson(this);
}
