import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hive_cache_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class HiveCacheModel {
  @HiveField(0)
  final String responseBody;
  
  @HiveField(1)
  final DateTime cachedAt;

  HiveCacheModel({
    required this.responseBody,
    required this.cachedAt,
  });

  factory HiveCacheModel.fromJson(Map<String, dynamic> json) =>
      _$HiveCacheModelFromJson(json);
  Map<String, dynamic> toJson() => _$HiveCacheModelToJson(this);
}