import 'package:brave_steve/core/di/providers.dart';
import 'package:brave_steve/core/modules/models/enums.dart';
import 'package:brave_steve/modules/eq/menagment/eq_state.dart';
import 'package:brave_steve/modules/sounds/menagment/sound_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MergeItemModel extends Equatable {
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
  final int fromEQId;
  final int? numerZestawu;

  const MergeItemModel(
      {required this.name,
      required this.description,
      required this.image,
      this.attack,
      this.armour,
      required this.classItem,
      required this.price,
      required this.itemLevel,
      required this.upgradePrice,
      required this.itemRarity,
      required this.fromEQId,
      required this.numerZestawu});

  MergeItemModel copywith(
      {String? name,
      String? description,
      String? image,
      int? attack,
      int? armour,
      ItemTypeModel? classItem,
      int? price,
      int? itemLevel,
      int? upgradePrice,
      String? itemRarity,
      int? fromEQId,
      int? numerZestawu}) {
    return MergeItemModel(
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        attack: attack ?? this.attack,
        armour: armour ?? this.armour,
        classItem: classItem ?? this.classItem,
        price: price ?? this.price,
        itemLevel: itemLevel ?? this.itemLevel,
        upgradePrice: upgradePrice ?? this.upgradePrice,
        itemRarity: itemRarity ?? this.itemRarity,
        fromEQId: fromEQId ?? this.fromEQId,
        numerZestawu: numerZestawu ?? this.numerZestawu);
  }

  @override
  List<Object?> get props => [
        name,
        description,
        image,
        attack,
        armour,
        classItem,
        price,
        itemLevel,
        upgradePrice,
        itemRarity,
        fromEQId,
        numerZestawu
      ];
}

class MergeItemState extends Notifier<List<MergeItemModel>> {
  @override
  build() {
    return [];
  }

  void addMergeItem(int id) {
    if(state.length == 2) return;
    final eqList = ref.read(providerEQ);
    final item = eqList[id].item;
    if(item.itemRarity == 'mithic') return;
    MergeItemModel mergeItem = MergeItemModel(
        fromEQId: id,
        name: item.name,
        description: item.description,
        image: item.image,
        attack: item.attack,
        armour: item.armour,
        classItem: item.classItem,
        price: item.price,
        itemLevel: item.itemLevel,
        upgradePrice: item.upgradePrice,
        itemRarity: item.itemRarity,
        numerZestawu: item.numerZestawu);
    if(mergeItem.fromEQId == state.firstOrNull?.fromEQId) return;
    state = [...state, mergeItem];
  }

  void removeMergeItem(int id) {
    state = state.where((item) => item != state[id]).toList();
  }

  void mergeItems() {
    if (state.length < 2) {
      return;
    }
    if(state[0].itemRarity != state[1].itemRarity ||
    state[0].numerZestawu != state[1].numerZestawu ||
    state[0].itemRarity == 'mithic' && state[1].itemRarity == 'mithic'
    || state[0].fromEQId == state[1].fromEQId || state[0].classItem != state[1].classItem) {
      return;
    }
    final item1 = state[0];
    final mergedItem = ref.read(mergeRepoProvider).takeBetterItem(item1.itemRarity,item1.classItem,item1.numerZestawu);
    state = [...state, mergedItem];
    ref.read(soundManagerProvider.notifier).playMerge();
  }

  void clear() {
    state = [];
  }


}


final providerMergeItem = NotifierProvider<MergeItemState, List<MergeItemModel>>(() {
  return MergeItemState();
});