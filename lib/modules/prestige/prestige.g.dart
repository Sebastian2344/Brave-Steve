// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prestige.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrestigeAdapter extends TypeAdapter<Prestige> {
  @override
  final int typeId = 7;

  @override
  Prestige read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Prestige(
      attack: fields[1] == null ? 0.0 : fields[1] as double,
      health: fields[2] == null ? 0.0 : fields[2] as double,
      points: fields[0] == null ? 0 : fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Prestige obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.points)
      ..writeByte(1)
      ..write(obj.attack)
      ..writeByte(2)
      ..write(obj.health);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrestigeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
