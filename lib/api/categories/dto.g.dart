// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModelRequest _$CategoryModelRequestFromJson(
        Map<String, dynamic> json) =>
    CategoryModelRequest(
      parent_id: json['parent_id'] as int?,
      name: json['name'] as String?,
      name_long: json['name_long'] as String?,
      icon_id: json['icon_id'] as int?,
      sort_order: json['sort_order'] as int?,
      description: json['description'] as String?,
      isHome: json['is_home'] as bool?,
      subcategories_title: json['subcategories_title'] as String?,
      show_checkin_history: json['show_checkin_history'] as bool?,
      checkin_enabled: json['checkin_enabled'] as bool?,
      guidelines_file_link: json['guidelines_file_link'] as String?,
      prompt: json['prompt'] as String?,
      prompt_checkin: json['prompt_checkin'] as String?,
      prompt_checkin_proposal: json['prompt_checkin_proposal'] as String?,
      prompt_followup: json['prompt_followup'] as String?,
      followup_chat_enabled: json['followup_chat_enabled'] as bool?,
      followup_timer: json['followup_timer'] as int?,
    );

Map<String, dynamic> _$CategoryModelRequestToJson(
        CategoryModelRequest instance) =>
    <String, dynamic>{
      'parent_id': instance.parent_id,
      'name': instance.name,
      'name_long': instance.name_long,
      'icon_id': instance.icon_id,
      'sort_order': instance.sort_order,
      'description': instance.description,
      'is_home': instance.isHome,
      'subcategories_title': instance.subcategories_title,
      'show_checkin_history': instance.show_checkin_history,
      'checkin_enabled': instance.checkin_enabled,
      'guidelines_file_link': instance.guidelines_file_link,
      'prompt': instance.prompt,
      'prompt_checkin': instance.prompt_checkin,
      'prompt_checkin_proposal': instance.prompt_checkin_proposal,
      'prompt_followup': instance.prompt_followup,
      'followup_chat_enabled': instance.followup_chat_enabled,
      'followup_timer': instance.followup_timer,
    };

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      parent_id: json['parent_id'] as int?,
      name: json['name'] as String?,
      name_long: json['name_long'] as String?,
      icon_id: json['icon_id'] as int?,
      sort_order: json['sort_order'] as int?,
      description: json['description'] as String?,
      is_home: json['is_home'] as bool?,
      subcategories_title: json['subcategories_title'] as String?,
      show_checkin_history: json['show_checkin_history'] as bool?,
      checkin_enabled: json['checkin_enabled'] as bool?,
      guidelines_file_link: json['guidelines_file_link'] as String?,
      prompt: json['prompt'] as String?,
      prompt_checkin: json['prompt_checkin'] as String?,
      prompt_checkin_proposal: json['prompt_checkin_proposal'] as String?,
      prompt_followup: json['prompt_followup'] as String?,
      followup_chat_enabled: json['followup_chat_enabled'] as bool?,
      followup_timer: json['followup_timer'] as int?,
      id: json['id'] as int?,
      time_create: json['time_create'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'parent_id': instance.parent_id,
      'name': instance.name,
      'name_long': instance.name_long,
      'icon_id': instance.icon_id,
      'sort_order': instance.sort_order,
      'description': instance.description,
      'is_home': instance.is_home,
      'subcategories_title': instance.subcategories_title,
      'show_checkin_history': instance.show_checkin_history,
      'checkin_enabled': instance.checkin_enabled,
      'guidelines_file_link': instance.guidelines_file_link,
      'prompt': instance.prompt,
      'prompt_checkin': instance.prompt_checkin,
      'prompt_checkin_proposal': instance.prompt_checkin_proposal,
      'prompt_followup': instance.prompt_followup,
      'followup_chat_enabled': instance.followup_chat_enabled,
      'followup_timer': instance.followup_timer,
      'id': instance.id,
      'time_create': instance.time_create,
    };
