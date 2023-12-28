// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInRequestModel _$CheckInRequestModelFromJson(Map<String, dynamic> json) =>
    CheckInRequestModel(
      user_category_id: json['user_category_id'] as int?,
      date: json['date'] as String?,
      level: (json['level'] as num?)?.toDouble(),
      summary: json['summary'] as String?,
      full_text: json['full_text'] as String?,
    );

Map<String, dynamic> _$CheckInRequestModelToJson(
        CheckInRequestModel instance) =>
    <String, dynamic>{
      'user_category_id': instance.user_category_id,
      'date': instance.date,
      'level': instance.level,
      'summary': instance.summary,
      'full_text': instance.full_text,
    };

CheckInModel _$CheckInModelFromJson(Map<String, dynamic> json) => CheckInModel(
      user_category_id: json['user_category_id'] as int?,
      date: json['date'] as String?,
      level: (json['level'] as num?)?.toDouble(),
      summary: json['summary'] as String?,
      full_text: json['full_text'] as String?,
      id: json['id'] as int?,
      time_create: json['time_create'] as String?,
    );

Map<String, dynamic> _$CheckInModelToJson(CheckInModel instance) =>
    <String, dynamic>{
      'user_category_id': instance.user_category_id,
      'date': instance.date,
      'level': instance.level,
      'summary': instance.summary,
      'full_text': instance.full_text,
      'id': instance.id,
      'time_create': instance.time_create,
    };
