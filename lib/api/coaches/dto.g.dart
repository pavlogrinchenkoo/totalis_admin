// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoachesRequestModel _$CoachesRequestModelFromJson(Map<String, dynamic> json) =>
    CoachesRequestModel(
      name: json['name'] as String?,
      description: json['description'] as String?,
      image_id: json['image_id'] as int?,
      prompt: json['prompt'] as String?,
    );

Map<String, dynamic> _$CoachesRequestModelToJson(
        CoachesRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'image_id': instance.image_id,
      'prompt': instance.prompt,
    };

CoachesModel _$CoachesModelFromJson(Map<String, dynamic> json) => CoachesModel(
      name: json['name'] as String?,
      description: json['description'] as String?,
      image_id: json['image_id'] as int?,
      prompt: json['prompt'] as String?,
      id: json['id'] as int?,
      time_create: json['time_create'] as String?,
    );

Map<String, dynamic> _$CoachesModelToJson(CoachesModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'image_id': instance.image_id,
      'prompt': instance.prompt,
      'id': instance.id,
      'time_create': instance.time_create,
    };
