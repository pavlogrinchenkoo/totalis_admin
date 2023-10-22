// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationRequestModel _$RecommendationRequestModelFromJson(
        Map<String, dynamic> json) =>
    RecommendationRequestModel(
      checkin_id: json['checkin_id'] as int?,
      text: json['text'] as String?,
    );

Map<String, dynamic> _$RecommendationRequestModelToJson(
        RecommendationRequestModel instance) =>
    <String, dynamic>{
      'checkin_id': instance.checkin_id,
      'text': instance.text,
    };

RecommendationModel _$RecommendationModelFromJson(Map<String, dynamic> json) =>
    RecommendationModel(
      checkin_id: json['checkin_id'] as int?,
      text: json['text'] as String?,
      id: json['id'] as int?,
      time_create: json['time_create'] as String?,
    );

Map<String, dynamic> _$RecommendationModelToJson(
        RecommendationModel instance) =>
    <String, dynamic>{
      'checkin_id': instance.checkin_id,
      'text': instance.text,
      'id': instance.id,
      'time_create': instance.time_create,
    };
