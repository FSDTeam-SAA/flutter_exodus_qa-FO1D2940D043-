// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_cache_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCacheModelAdapter extends TypeAdapter<HiveCacheModel> {
  @override
  final int typeId = 0;

  @override
  HiveCacheModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCacheModel(
      responseBody: fields[0] as String,
      cachedAt: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCacheModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.responseBody)
      ..writeByte(1)
      ..write(obj.cachedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCacheModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HiveCacheModel _$HiveCacheModelFromJson(Map<String, dynamic> json) =>
    HiveCacheModel(
      responseBody: json['responseBody'] as String,
      cachedAt: DateTime.parse(json['cachedAt'] as String),
    );

Map<String, dynamic> _$HiveCacheModelToJson(HiveCacheModel instance) =>
    <String, dynamic>{
      'responseBody': instance.responseBody,
      'cachedAt': instance.cachedAt.toIso8601String(),
    };
