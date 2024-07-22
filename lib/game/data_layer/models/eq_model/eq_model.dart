enum FieldTypeModel { helmet, chestplate, sword, pants, boots, backpack }
enum ItemTypeModel { helmet, chestplate, sword, pants, boots , none }
enum EqState { notEnoughtSpace, haveFreeSpace }
class ItemPlaceModel {
  final int id;
  final bool isEmpty;
  final FieldTypeModel classField;
  final ItemModel item;
  ItemPlaceModel(this.id, this.isEmpty, this.classField, this.item);
}

class ItemModel {
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
}