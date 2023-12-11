// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemModel _$SystemModelFromJson(Map<String, dynamic> json) => SystemModel(
      openapi_key: json['openapi_key'] as String?,
      model_gpt_version: json['model_gpt_version'] as String?,
      prompt_why: json['prompt_why'] as String?,
      prompt_how: json['prompt_how'] as String?,
      model_temperature: (json['model_temperature'] as num?)?.toDouble(),
      model_max_response_token:
          (json['model_max_response_token'] as num?)?.toDouble(),
      model_presence_penalty:
          (json['model_presence_penalty'] as num?)?.toDouble(),
      model_frequency_penalty:
          (json['model_frequency_penalty'] as num?)?.toDouble(),
      context_limit: (json['context_limit'] as num?)?.toDouble(),
      show_msg_history: (json['show_msg_history'] as num?)?.toDouble(),
      summarize_frequency: (json['summarize_frequency'] as num?)?.toDouble(),
      test_days_forward: (json['test_days_forward'] as num?)?.toDouble(),
      login_timeout: (json['login_timeout'] as num?)?.toDouble(),
      message_cache: (json['message_cache'] as num?)?.toDouble(),
      id: json['id'] as int?,
      time_create: json['time_create'] as String?,
    );

Map<String, dynamic> _$SystemModelToJson(SystemModel instance) =>
    <String, dynamic>{
      'openapi_key': instance.openapi_key,
      'model_gpt_version': instance.model_gpt_version,
      'prompt_why': instance.prompt_why,
      'prompt_how': instance.prompt_how,
      'model_temperature': instance.model_temperature,
      'model_max_response_token': instance.model_max_response_token,
      'model_presence_penalty': instance.model_presence_penalty,
      'model_frequency_penalty': instance.model_frequency_penalty,
      'context_limit': instance.context_limit,
      'show_msg_history': instance.show_msg_history,
      'summarize_frequency': instance.summarize_frequency,
      'test_days_forward': instance.test_days_forward,
      'login_timeout': instance.login_timeout,
      'message_cache': instance.message_cache,
      'id': instance.id,
      'time_create': instance.time_create,
    };
