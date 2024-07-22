// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerAdapter extends TypeAdapter<Player> {
  @override
  final int typeId = 1;

  @override
  Player read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Player(
      fields[0] as String,
      fields[1] as double,
      fields[2] as double,
      fields[3] as double,
      fields[11] as double,
      fields[4] as double,
      fields[5] as double,
      fields[6] as double,
      fields[7] as double,
      fields[8] as int,
      fields[9] as bool,
      fields[10] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Player obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj._name)
      ..writeByte(1)
      ..write(obj._hp)
      ..writeByte(2)
      ..write(obj._maxHp)
      ..writeByte(3)
      ..write(obj._attack)
      ..writeByte(4)
      ..write(obj._mana)
      ..writeByte(5)
      ..write(obj._exp)
      ..writeByte(6)
      ..write(obj._armour)
      ..writeByte(7)
      ..write(obj._maxArmour)
      ..writeByte(8)
      ..write(obj._lvl)
      ..writeByte(9)
      ..write(obj._weak)
      ..writeByte(10)
      ..write(obj._enemyIndex)
      ..writeByte(11)
      ..write(obj._maxAttack);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
