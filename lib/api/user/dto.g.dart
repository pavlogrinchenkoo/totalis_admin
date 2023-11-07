// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRequestModel _$UserRequestModelFromJson(Map<String, dynamic> json) =>
    UserRequestModel(
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      firebase_uid: json['firebase_uid'] as String?,
      image_id: json['image_id'] as int?,
      is_tester: json['is_tester'] as bool?,
      sex: $enumDecodeNullable(_$SexEnumEnumMap, json['sex']),
      birth: json['birth'] as String?,
      coach_id: json['coach_id'] as int?,
    );

Map<String, dynamic> _$UserRequestModelToJson(UserRequestModel instance) =>
    <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'firebase_uid': instance.firebase_uid,
      'image_id': instance.image_id,
      'is_tester': instance.is_tester,
      'sex': _$SexEnumEnumMap[instance.sex],
      'birth': instance.birth,
      'coach_id': instance.coach_id,
    };

const _$SexEnumEnumMap = {
  SexEnum.M: 'M',
  SexEnum.F: 'F',
  SexEnum.N: 'N',
};

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      firebase_uid: json['firebase_uid'] as String?,
      image_id: json['image_id'] as int?,
      is_tester: json['is_tester'] as bool?,
      sex: $enumDecodeNullable(_$SexEnumEnumMap, json['sex']),
      birth: json['birth'] as String?,
      coach_id: json['coach_id'] as int?,
      time_create: json['time_create'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'firebase_uid': instance.firebase_uid,
      'image_id': instance.image_id,
      'is_tester': instance.is_tester,
      'sex': _$SexEnumEnumMap[instance.sex],
      'birth': instance.birth,
      'coach_id': instance.coach_id,
      'time_create': instance.time_create,
    };
