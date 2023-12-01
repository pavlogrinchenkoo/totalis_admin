// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class ModelsChatGptRequestModel {
  String? value;

  ModelsChatGptRequestModel({this.value});

  factory ModelsChatGptRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ModelsChatGptRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModelsChatGptRequestModelToJson(this);
}

@JsonSerializable()
class ModelsChatGptModel {
  String? value;
  int? id;
  String? time_create;

  ModelsChatGptModel({
    this.value,
    this.id,
    this.time_create,
  });

  factory ModelsChatGptModel.fromJson(Map<String, dynamic> json) =>
      _$ModelsChatGptModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModelsChatGptModelToJson(this);
}
