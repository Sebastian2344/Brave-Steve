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
      name: fields[0] as String,
      hp: fields[1] as double,
      maxHp: fields[2] as double,
      attack: fields[3] as double,
      mana: fields[4] as double,
      exp: fields[5] as double,
      lvl: fields[6] as int,
      weak: fields[7] as bool,
      enemyIndex: fields[8] as int?,
      damageReduction: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Player obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.hp)
      ..writeByte(2)
      ..write(obj.maxHp)
      ..writeByte(3)
      ..write(obj.attack)
      ..writeByte(4)
      ..write(obj.mana)
      ..writeByte(5)
      ..write(obj.exp)
      ..writeByte(6)
      ..write(obj.lvl)
      ..writeByte(7)
      ..write(obj.weak)
      ..writeByte(8)
      ..write(obj.enemyIndex)
      ..writeByte(9)
      ..write(obj.damageReduction);
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
