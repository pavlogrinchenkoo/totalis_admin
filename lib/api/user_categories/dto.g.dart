// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCategoryRequestModel _$UserCategoryRequestModelFromJson(
        Map<String, dynamic> json) =>
    UserCategoryRequestModel(
      user_id: json['user_id'] as int?,
      category_id: json['category_id'] as int?,
      is_favorite: json['is_favorite'] as bool? ?? false,
      muted_day: json['muted_day'] as String? ?? '',
      muted_for: json['muted_for'] as String? ?? '',
      chat_summary_long: json['chat_summary_long'] as String? ?? '',
      chat_summary_short: json['chat_summary_short'] as String? ?? '',
      used_chat: json['used_chat'] as bool? ?? false,
      is_read: json['is_read'] as bool? ?? true,
    );

Map<String, dynamic> _$UserCategoryRequestModelToJson(
        UserCategoryRequestModel instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'category_id': instance.category_id,
      'is_favorite': instance.is_favorite,
      'muted_day': instance.muted_day,
      'muted_for': instance.muted_for,
      'chat_summary_long': instance.chat_summary_long,
      'chat_summary_short': instance.chat_summary_short,
      'used_chat': instance.used_chat,
      'is_read': instance.is_read,
    };

UserCategoryModel _$UserCategoryModelFromJson(Map<String, dynamic> json) =>
    UserCategoryModel(
      user_id: json['user_id'] as int?,
      category_id: json['category_id'] as int?,
      is_favorite: json['is_favorite'] as bool?,
      muted_day: json['muted_day'] as String?,
      muted_for: json['muted_for'] as String?,
      chat_summary_long: json['chat_summary_long'] as String?,
      chat_summary_short: json['chat_summary_short'] as String?,
      used_chat: json['used_chat'] as bool?,
      is_read: json['is_read'] as bool?,
      id: json['id'] as int?,
      time_create: json['time_create'] as String?,
    );

Map<String, dynamic> _$UserCategoryModelToJson(UserCategoryModel instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'category_id': instance.category_id,
      'is_favorite': instance.is_favorite,
      'muted_day': instance.muted_day,
      'muted_for': instance.muted_for,
      'chat_summary_long': instance.chat_summary_long,
      'chat_summary_short': instance.chat_summary_short,
      'used_chat': instance.used_chat,
      'is_read': instance.is_read,
      'id': instance.id,
      'time_create': instance.time_create,
    };
