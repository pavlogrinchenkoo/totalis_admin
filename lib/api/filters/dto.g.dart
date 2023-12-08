// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filters _$FiltersFromJson(Map<String, dynamic> json) => Filters(
      field: json['field'] as String,
      value: json['value'],
    );

Map<String, dynamic> _$FiltersToJson(Filters instance) => <String, dynamic>{
      'field': instance.field,
      'value': instance.value,
    };

Orders _$OrdersFromJson(Map<String, dynamic> json) => Orders(
      field: json['field'] as String,
      desc: json['desc'] as bool,
    );

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
      'field': instance.field,
      'desc': instance.desc,
    };

QueryModel _$QueryModelFromJson(Map<String, dynamic> json) => QueryModel(
      filters: (json['filters'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : Filters.fromJson(e as Map<String, dynamic>))
          .toList(),
      orders: (json['orders'] as List<dynamic>?)
              ?.map((e) =>
                  e == null ? null : Orders.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      page: json['page'] as int?,
      count: json['count'] as int?,
    );

Map<String, dynamic> _$QueryModelToJson(QueryModel instance) =>
    <String, dynamic>{
      'filters': instance.filters,
      'orders': instance.orders,
      'page': instance.page,
      'count': instance.count,
    };
