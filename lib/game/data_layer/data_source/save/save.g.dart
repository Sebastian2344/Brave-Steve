// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaveAdapter extends TypeAdapter<Save> {
  @override
  final int typeId = 0;

  @override
  Save read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Save(
      list: (fields[0] as List).cast<Player>(),
      name: fields[1] as String,
      itemPlace: (fields[2] as List).cast<ItemPlace>(),
    );
  }

  @override
  void write(BinaryWriter writer, Save obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.list)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.itemPlace);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
