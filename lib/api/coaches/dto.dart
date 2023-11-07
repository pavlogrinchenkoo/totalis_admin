// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:totalis_admin/api/user/request.dart';

part 'dto.g.dart';

@JsonSerializable()
class CoachesRequestModel {
  String? name;
  String? description;
  int? image_id;
  String? prompt;
  SexEnum? sex;

  CoachesRequestModel({
    this.name,
    this.description,
    this.image_id,
    this.prompt,
    this.sex,
  });

  factory CoachesRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CoachesRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoachesRequestModelToJson(this);
}

@JsonSerializable()
class CoachesModel {
  String? name;
  String? description;
  int? image_id;
  String? prompt;
  SexEnum? sex;
  int? id;
  String? time_create;

  CoachesModel({
    this.name,
    this.description,
    this.image_id,
    this.prompt,
    this.sex,
    this.id,
    this.time_create,
  });

  factory CoachesModel.fromJson(Map<String, dynamic> json) =>
      _$CoachesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoachesModelToJson(this);
}
