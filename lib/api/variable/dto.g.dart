// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariableRequestModel _$VariableRequestModelFromJson(
        Map<String, dynamic> json) =>
    VariableRequestModel(
      name: json['name'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$VariableRequestModelToJson(
        VariableRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };

VariableModel _$VariableModelFromJson(Map<String, dynamic> json) =>
    VariableModel(
      name: json['name'] as String?,
      value: json['value'] as String?,
      id: json['id'] as int?,
      time_create: json['time_create'] as String?,
    );

Map<String, dynamic> _$VariableModelToJson(VariableModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'id': instance.id,
      'time_create': instance.time_create,
    };
