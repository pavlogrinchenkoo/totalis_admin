// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelsChatGptRequestModel _$ModelsChatGptRequestModelFromJson(
        Map<String, dynamic> json) =>
    ModelsChatGptRequestModel(
      value: json['value'] as String?,
    );

Map<String, dynamic> _$ModelsChatGptRequestModelToJson(
        ModelsChatGptRequestModel instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

ModelsChatGptModel _$ModelsChatGptModelFromJson(Map<String, dynamic> json) =>
    ModelsChatGptModel(
      value: json['value'] as String?,
      id: json['id'] as int?,
      time_create: json['time_create'] as String?,
    );

Map<String, dynamic> _$ModelsChatGptModelToJson(ModelsChatGptModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'id': instance.id,
      'time_create': instance.time_create,
    };
