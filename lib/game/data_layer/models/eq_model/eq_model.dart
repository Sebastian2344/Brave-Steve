import 'package:equatable/equatable.dart';
enum FieldTypeModel { helmet, chestplate, sword, pants, boots, backpack }
enum ItemTypeModel { helmet, chestplate, sword, pants, boots , none }
enum EqState { notEnoughtSpace, haveFreeSpace }
class ItemPlaceModel extends Equatable {
  final int id;
  final bool isEmpty;
  final FieldTypeModel classField;
  final ItemModel item;
  const ItemPlaceModel(this.id, this.isEmpty, this.classField, this.item);

  @override
  List<Object?> get props => [id, isEmpty, classField, item];
}

class ItemModel extends Equatable {
  final String name;
  final String description;
  final String image;
  final int statValue;
  final ItemTypeModel classItem;

 const ItemModel(
    this.name,
    this.description,
    this.image,
    this.statValue,
    this.classItem,
  );

  @override
  List<Object?> get props => [name, description, image, statValue, classItem];
}