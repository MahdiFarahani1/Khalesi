// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelDataBaseAdapter extends TypeAdapter<ModelDataBase> {
  @override
  final int typeId = 0;

  @override
  ModelDataBase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelDataBase(
      id: fields[3] as int,
      path: fields[1] as String,
      time: fields[2] as String,
      title: fields[0] as String,
      categoryTitle: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ModelDataBase obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.categoryTitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelDataBaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
