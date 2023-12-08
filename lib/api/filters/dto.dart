// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class Filters {
  String field;
  dynamic value;

  Filters({
    required this.field,
    required this.value,
  });

  factory Filters.fromJson(Map<String, dynamic> json) =>
      _$FiltersFromJson(json);

  Map<String, dynamic> toJson() => _$FiltersToJson(this);
}

@JsonSerializable()
class Orders {
  String field;
  bool desc;

  Orders({
    required this.field,
    required this.desc,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersToJson(this);
}

@JsonSerializable()
class QueryModel {
  List<Filters?>? filters;
  List<Orders?> orders;
  int? page;
  int? count;

  QueryModel({
    this.filters,
    this.orders = const [],
    this.page,
    this.count,
  });

  factory QueryModel.fromJson(Map<String, dynamic> json) =>
      _$QueryModelFromJson(json);

  Map<String, dynamic> toJson() => _$QueryModelToJson(this);
}
