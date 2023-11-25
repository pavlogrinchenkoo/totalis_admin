// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class SystemModel {
  String? openapi_key;
  String? model_gpt_version;
  String? prompt_why;
  String? prompt_how;
  int? model_temperature;
  int? model_max_response_token;
  int? model_presence_penalty;
  int? model_frequency_penalty;
  int? context_limit;
  int? show_msg_history;
  int? summarize_frequency;
  int? test_days_forward;
  int? login_timeout;
  int? message_cache;
  int? id;
  String? time_create;

  SystemModel({
    this.openapi_key,
    this.model_gpt_version,
    this.prompt_why,
    this.prompt_how,
    this.model_temperature,
    this.model_max_response_token,
    this.model_presence_penalty,
    this.model_frequency_penalty,
    this.context_limit,
    this.show_msg_history,
    this.summarize_frequency,
    this.test_days_forward,
    this.login_timeout,
    this.message_cache,
    this.id,
    this.time_create,
  });

  factory SystemModel.fromJson(Map<String, dynamic> json) =>
      _$SystemModelFromJson(json);

  Map<String, dynamic> toJson() => _$SystemModelToJson(this);
}
