// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class RecommendationRequestModel {
  int? checkin_id;
  String? text;

  RecommendationRequestModel({this.checkin_id, this.text});

  factory RecommendationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationRequestModelToJson(this);
}

@JsonSerializable()
class RecommendationModel {
  int? checkin_id;
  String? text;
  int? id;
  String? time_create;

  RecommendationModel({
    this.checkin_id,
    this.text,
    this.id,
    this.time_create,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendationModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationModelToJson(this);
}
