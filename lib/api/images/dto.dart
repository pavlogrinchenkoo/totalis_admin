// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class ImageRequestModel {
  String data;
  String extension;
  int? user_id;

  ImageRequestModel(
      {required this.data, required this.extension, this.user_id});

  factory ImageRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ImageRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageRequestModelToJson(this);
}

@JsonSerializable()
class ImageModel {
  String? data;
  String? extension;
  int? user_id;
  int? id;
  String? time_create;

  ImageModel({
    this.data,
    this.extension,
    this.user_id,
    this.id,
    this.time_create,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}
