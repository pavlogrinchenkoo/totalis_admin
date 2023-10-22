// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminRequestModel _$AdminRequestModelFromJson(Map<String, dynamic> json) =>
    AdminRequestModel(
      name: json['name'] as String?,
      mail: json['mail'] as String?,
      enabled: json['enabled'] as bool? ?? true,
      super_admin: json['super_admin'] as bool? ?? false,
      firebase_uid: json['firebase_uid'] as String?,
    );

Map<String, dynamic> _$AdminRequestModelToJson(AdminRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mail': instance.mail,
      'enabled': instance.enabled,
      'super_admin': instance.super_admin,
      'firebase_uid': instance.firebase_uid,
    };

AdminModel _$AdminModelFromJson(Map<String, dynamic> json) => AdminModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      mail: json['mail'] as String?,
      enabled: json['enabled'] as bool?,
      super_admin: json['super_admin'] as bool?,
      firebase_uid: json['firebase_uid'] as String?,
      time_create: json['time_create'] as String?,
    );

Map<String, dynamic> _$AdminModelToJson(AdminModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mail': instance.mail,
      'enabled': instance.enabled,
      'super_admin': instance.super_admin,
      'firebase_uid': instance.firebase_uid,
      'time_create': instance.time_create,
    };
