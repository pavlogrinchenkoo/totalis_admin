// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class VariableRequestModel {
  String? name;
  String? value;

  VariableRequestModel({this.name, this.value});

  factory VariableRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VariableRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$VariableRequestModelToJson(this);
}

@JsonSerializable()
class VariableModel {
  String? name;
  String? value;
  int? id;
  String? time_create;

  VariableModel({
    this.name,
    this.value,
    this.id,
    this.time_create,
  });

  factory VariableModel.fromJson(Map<String, dynamic> json) =>
      _$VariableModelFromJson(json);

  Map<String, dynamic> toJson() => _$VariableModelToJson(this);
}
