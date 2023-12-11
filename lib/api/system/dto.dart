// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class SystemModel {
  String? openapi_key;
  String? model_gpt_version;
  String? prompt_why;
  String? prompt_how;
  double? model_temperature;
  double? model_max_response_token;
  double? model_presence_penalty;
  double? model_frequency_penalty;
  double? context_limit;
  double? show_msg_history;
  double? summarize_frequency;
  double? test_days_forward;
  double? login_timeout;
  double? message_cache;
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
