import 'package:equatable/equatable.dart';
enum FieldTypeModel { helmet, chestplate, sword, pants, boots, backpack }
enum ItemTypeModel { helmet, chestplate, sword, pants, boots , none }
enum EqState { notEnoughtSpace, haveFreeSpace }
class ItemPlaceModel extends Equatable {
  final int id;
  final bool isEmpty;
  final FieldTypeModel classField;
  final ItemModel item;
  const ItemPlaceModel({required this.id,required  this.isEmpty,required  this.classField,required  this.item});

  @override
  List<Object?> get props => [id, isEmpty, classField, item];
}

class ItemModel extends Equatable {
  final String name;
  final String description;
  final String image;
  final int attack;
  final int armour;
  final ItemTypeModel classItem;
  final int price;

 const ItemModel({
    required this.name,
    required this.description,
    required this.image,
    required this.attack,
    required this.armour,
    required this.classItem,
    required this.price
  });

  @override
  List<Object?> get props => [name, description, image, attack, armour, classItem, price];
}