// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class CoachesRequestModel {
  String? name;
  String? description;
  String? avatar;
  String? prompt;

  CoachesRequestModel({
    this.name,
    this.description,
    this.avatar,
    this.prompt,
  });

  factory CoachesRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CoachesRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoachesRequestModelToJson(this);
}

@JsonSerializable()
class CoachesModel {
  String? name;
  String? description;
  String? avatar;
  String? prompt;
  int? id;
  String? time_create;

  CoachesModel({
    this.name,
    this.description,
    this.avatar,
    this.prompt,
    this.id,
    this.time_create,
  });

  factory CoachesModel.fromJson(Map<String, dynamic> json) =>
      _$CoachesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoachesModelToJson(this);
}
