import 'package:equatable/equatable.dart';

enum FieldTypeModel { helmet, chestplate, sword, pants, boots, backpack }

enum ItemTypeModel { helmet, chestplate, sword, pants, boots, none }

enum EqState { notEnoughtSpace, haveFreeSpace }

class EqModel extends Equatable {
  final List<ItemPlaceModel> eqList;
  final StatsModelToAddStatsPlayer stats;
  const EqModel({required this.eqList, required this.stats});

  EqModel copywith({List<ItemPlaceModel>? eqList, StatsModelToAddStatsPlayer? stats}) {
    return EqModel(eqList: eqList ?? this.eqList, stats: stats ?? this.stats);
  }

  @override
  List<Object?> get props => [eqList, stats];
}

class StatsModelToAddStatsPlayer extends Equatable{
  final double attack;
  final double armour;
  const StatsModelToAddStatsPlayer({required this.attack, required this.armour});

  StatsModelToAddStatsPlayer copywith({double? attack, double? armour}) {
    return StatsModelToAddStatsPlayer(
        attack: attack ?? this.attack, armour: armour ?? this.armour);
  }

  @override
  List<Object?> get props => [attack, armour];
}

class ItemPlaceModel extends Equatable {
  final int id;
  final bool isEmpty;
  final FieldTypeModel classField;
  final ItemModel item;
  const ItemPlaceModel(
      {required this.id,
      required this.isEmpty,
      required this.classField,
      required this.item});

  ItemPlaceModel copywith(
      {int? id, bool? isEmpty, FieldTypeModel? classField, ItemModel? item}) {
    return ItemPlaceModel(
        id: id ?? this.id,
        isEmpty: isEmpty ?? this.isEmpty,
        classField: classField ?? this.classField,
        item: item ?? this.item);
  }

  @override
  List<Object?> get props => [id, isEmpty, classField, item];
}

class ItemModel extends Equatable {
  final String name;
  final String description;
  final String image;
  final int? attack;
  final int? armour;
  final ItemTypeModel classItem;
  final int price;
  final int itemLevel;
  final int upgradePrice;
  final String itemRarity;

  const ItemModel({
    this.name = '',
    this.description = '',
    this.image = '',
    this.attack,
    this.armour,
    this.classItem = ItemTypeModel.none,
    this.price = 0,
    this.itemLevel = 0,
    this.upgradePrice = 0,
    this.itemRarity = 'none',
  });

  ItemModel copywith(
      {String? name,
      String? description,
      String? image,
      int? attack,
      int? armour,
      ItemTypeModel? itemtypemodel,
      int? price,
      int? itemLevel,
      int? upgradePrice,
      String? itemRarity}) {
    return ItemModel(
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      armour: armour ?? this.armour,
      attack: attack ?? this.attack,
      itemLevel: itemLevel ?? this.itemLevel,
      upgradePrice: upgradePrice ?? this.upgradePrice,
      price: price ?? this.price,
      classItem: itemtypemodel ?? classItem,
      itemRarity: itemRarity ?? this.itemRarity
    );
  }

  @override
  List<Object?> get props =>
      [name, description, image, attack, armour, classItem, price,upgradePrice,itemLevel,itemRarity];
}
