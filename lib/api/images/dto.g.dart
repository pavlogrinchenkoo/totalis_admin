// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageRequestModel _$ImageRequestModelFromJson(Map<String, dynamic> json) =>
    ImageRequestModel(
      data: json['data'] as String,
      extension: json['extension'] as String,
      user_id: json['user_id'] as int?,
    );

Map<String, dynamic> _$ImageRequestModelToJson(ImageRequestModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'extension': instance.extension,
      'user_id': instance.user_id,
    };

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      data: json['data'] as String?,
      extension: json['extension'] as String?,
      user_id: json['user_id'] as int?,
      id: json['id'] as int?,
      time_create: json['time_create'] as String?,
    );

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'extension': instance.extension,
      'user_id': instance.user_id,
      'id': instance.id,
      'time_create': instance.time_create,
    };
