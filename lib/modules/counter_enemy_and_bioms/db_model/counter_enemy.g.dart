// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_enemy.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CounterEnemyAdapter extends TypeAdapter<CounterEnemy> {
  @override
  final int typeId = 6;

  @override
  CounterEnemy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CounterEnemy(
      enemy: fields[0] as int,
      boss: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CounterEnemy obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.enemy)
      ..writeByte(1)
      ..write(obj.boss);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounterEnemyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
