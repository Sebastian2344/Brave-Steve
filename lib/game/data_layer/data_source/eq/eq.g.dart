// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eq.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemPlaceAdapter extends TypeAdapter<ItemPlace> {
  @override
  final int typeId = 2;

  @override
  ItemPlace read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemPlace(
      id: fields[0] as int,
      isEmpty: fields[1] as bool,
      classField: fields[2] as FieldType,
      item: fields[3] as Item,
    );
  }

  @override
  void write(BinaryWriter writer, ItemPlace obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isEmpty)
      ..writeByte(2)
      ..write(obj.classField)
      ..writeByte(3)
      ..write(obj.item);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemPlaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 3;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      name: fields[0] as String,
      description: fields[1] as String,
      image: fields[2] as String,
      classItem: fields[3] as ItemType,
      price: fields[4] as int,
      attack: fields[5] as int?,
      armour: fields[6] as int?,
      itemLevel: fields[7] == null ? 0 : fields[7] as int,
      upgradePrice: fields[8] == null ? 0 : fields[8] as int,
      rarity: fields[9] == null ? 'none' : fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.classItem)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.attack)
      ..writeByte(6)
      ..write(obj.armour)
      ..writeByte(7)
      ..write(obj.itemLevel)
      ..writeByte(8)
      ..write(obj.upgradePrice)
      ..writeByte(9)
      ..write(obj.rarity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FieldTypeAdapter extends TypeAdapter<FieldType> {
  @override
  final int typeId = 4;

  @override
  FieldType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FieldType.helmet;
      case 1:
        return FieldType.chestplate;
      case 2:
        return FieldType.sword;
      case 3:
        return FieldType.pants;
      case 4:
        return FieldType.boots;
      case 5:
        return FieldType.backpack;
      default:
        return FieldType.helmet;
    }
  }

  @override
  void write(BinaryWriter writer, FieldType obj) {
    switch (obj) {
      case FieldType.helmet:
        writer.writeByte(0);
        break;
      case FieldType.chestplate:
        writer.writeByte(1);
        break;
      case FieldType.sword:
        writer.writeByte(2);
        break;
      case FieldType.pants:
        writer.writeByte(3);
        break;
      case FieldType.boots:
        writer.writeByte(4);
        break;
      case FieldType.backpack:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FieldTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ItemTypeAdapter extends TypeAdapter<ItemType> {
  @override
  final int typeId = 5;

  @override
  ItemType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ItemType.helmet;
      case 1:
        return ItemType.chestplate;
      case 2:
        return ItemType.sword;
      case 3:
        return ItemType.pants;
      case 4:
        return ItemType.boots;
      case 5:
        return ItemType.none;
      default:
        return ItemType.helmet;
    }
  }

  @override
  void write(BinaryWriter writer, ItemType obj) {
    switch (obj) {
      case ItemType.helmet:
        writer.writeByte(0);
        break;
      case ItemType.chestplate:
        writer.writeByte(1);
        break;
      case ItemType.sword:
        writer.writeByte(2);
        break;
      case ItemType.pants:
        writer.writeByte(3);
        break;
      case ItemType.boots:
        writer.writeByte(4);
        break;
      case ItemType.none:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
