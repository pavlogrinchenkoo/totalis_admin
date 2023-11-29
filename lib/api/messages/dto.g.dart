// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageRequestModel _$MessageRequestModelFromJson(Map<String, dynamic> json) =>
    MessageRequestModel(
      user_category_id: json['user_category_id'] as int?,
      is_checkin: json['is_checkin'] as bool?,
      checkin_id: json['checkin_id'] as int?,
      coach_id: json['coach_id'] as int?,
      text: json['text'] as String?,
      role: $enumDecodeNullable(_$RoleEnumEnumMap, json['role']),
      tokens_used: json['tokens_used'] as int?,
      gpt_version: json['gpt_version'] as String?,
    );

Map<String, dynamic> _$MessageRequestModelToJson(
        MessageRequestModel instance) =>
    <String, dynamic>{
      'user_category_id': instance.user_category_id,
      'is_checkin': instance.is_checkin,
      'checkin_id': instance.checkin_id,
      'coach_id': instance.coach_id,
      'text': instance.text,
      'role': _$RoleEnumEnumMap[instance.role],
      'tokens_used': instance.tokens_used,
      'gpt_version': instance.gpt_version,
    };

const _$RoleEnumEnumMap = {
  RoleEnum.User: 'User',
  RoleEnum.Assistant: 'Assistant',
  RoleEnum.System: 'System',
};

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      user_category_id: json['user_category_id'] as int?,
      is_checkin: json['is_checkin'] as bool?,
      checkin_id: json['checkin_id'] as int?,
      coach_id: json['coach_id'] as int?,
      text: json['text'] as String?,
      role: $enumDecodeNullable(_$RoleEnumEnumMap, json['role']),
      tokens_used: json['tokens_used'] as int?,
      gpt_version: json['gpt_version'] as String?,
      id: json['id'] as int?,
      time_create: json['time_create'] as String?,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'user_category_id': instance.user_category_id,
      'is_checkin': instance.is_checkin,
      'checkin_id': instance.checkin_id,
      'coach_id': instance.coach_id,
      'text': instance.text,
      'role': _$RoleEnumEnumMap[instance.role],
      'tokens_used': instance.tokens_used,
      'gpt_version': instance.gpt_version,
      'id': instance.id,
      'time_create': instance.time_create,
    };
