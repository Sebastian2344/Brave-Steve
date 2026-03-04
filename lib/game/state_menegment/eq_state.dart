import 'package:brave_steve/game/data_layer/repo/eq_repo.dart';
import 'package:brave_steve/game/state_menegment/money_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data_layer/models/eq_model/eq_model.dart';

final providerEQ = NotifierProvider<EqStateMenagment, EqModel>(() {
  return EqStateMenagment();
});

class EqStateMenagment extends Notifier<EqModel> {
  EqRepo get eqRepo => ref.read(eqRepoProvider);

  @override
  build() {
    ref.watch(eqRepoProvider);
    return const EqModel(eqList: [
      ItemPlaceModel(
          id: 0,
          isEmpty: true,
          classField: FieldTypeModel.helmet,
          item: ItemModel()),
      ItemPlaceModel(
          id: 1,
          isEmpty: true,
          classField: FieldTypeModel.sword,
          item: ItemModel()),
      ItemPlaceModel(
          id: 2,
          isEmpty: true,
          classField: FieldTypeModel.chestplate,
          item: ItemModel()),
      ItemPlaceModel(
          id: 3,
          isEmpty: true,
          classField: FieldTypeModel.pants,
          item: ItemModel()),
      ItemPlaceModel(
          id: 4,
          isEmpty: true,
          classField: FieldTypeModel.boots,
          item: ItemModel()),
      ItemPlaceModel(
          id: 5,
          isEmpty: true,
          classField: FieldTypeModel.backpack,
          item: ItemModel()),
      ItemPlaceModel(
          id: 6,
          isEmpty: true,
          classField: FieldTypeModel.backpack,
          item: ItemModel()),
      ItemPlaceModel(
          id: 7,
          isEmpty: true,
          classField: FieldTypeModel.backpack,
          item: ItemModel()),
      ItemPlaceModel(
          id: 8,
          isEmpty: true,
          classField: FieldTypeModel.backpack,
          item: ItemModel()),
      ItemPlaceModel(
          id: 9,
          isEmpty: true,
          classField: FieldTypeModel.backpack,
          item: ItemModel()),
      ItemPlaceModel(
          id: 10,
          isEmpty: true,
          classField: FieldTypeModel.backpack,
          item: ItemModel()),
      ItemPlaceModel(
          id: 11,
          isEmpty: true,
          classField: FieldTypeModel.backpack,
          item: ItemModel()),
      ItemPlaceModel(
          id: 12,
          isEmpty: true,
          classField: FieldTypeModel.backpack,
          item: ItemModel()),
      ItemPlaceModel(
          id: 13,
          isEmpty: true,
          classField: FieldTypeModel.backpack,
          item: ItemModel()),
      ItemPlaceModel(
          id: 14,
          isEmpty: true,
          classField: FieldTypeModel.backpack,
          item: ItemModel()),
      ItemPlaceModel(
          id: 15,
          isEmpty: true,
          classField: FieldTypeModel.backpack,
          item: ItemModel()),
      ItemPlaceModel(
          id: 16,
          isEmpty: true,
          classField: FieldTypeModel.backpack,
          item: ItemModel()),
      ItemPlaceModel(
          id: 17,
          isEmpty: true,
          classField: FieldTypeModel.backpack,
          item: ItemModel()),
      ItemPlaceModel(
          id: 18,
          isEmpty: true,
          classField: FieldTypeModel.backpack,
          item: ItemModel()),
      ItemPlaceModel(
          id: 19,
          isEmpty: true,
          classField: FieldTypeModel.backpack,
          item: ItemModel()),
      ItemPlaceModel(
          id: 20,
          isEmpty: true,
          classField: FieldTypeModel.backpack,
          item: ItemModel()),
    ], stats: StatsModelToAddStatsPlayer(attack: 0, armour: 0));
  }

  void loadItemPlaceModels(int index) {
    List<ItemPlaceModel> o = eqRepo.getListFieldTypeModelFromDB(index);
    state = state
        .copywith(eqList: [for (final itemPlaceModel in o) itemPlaceModel]);
  }

  Future<void> upgradeItem(int id, double money) async {
    if (money < state.eqList[id].item.upgradePrice) {
      return;
    }
    double bill = state.eqList[id].item.upgradePrice.toDouble();
    if (eqRepo.isItemMaxLevel(
        state.eqList[id].item.itemLevel, state.eqList[id].item.itemRarity)) {
      return;
    }
    state = state.copywith(eqList: [
      for (final itemPlaceModel in state.eqList)
        if (itemPlaceModel.id == id)
          itemPlaceModel.copywith(
              item: state.eqList[id].item.copywith(
                  itemLevel: state.eqList[id].item.itemLevel + 1,
                  upgradePrice: state.eqList[id].item.upgradePrice + 20,
                  armour: state.eqList[id].item.armour != null
                      ? state.eqList[id].item.armour! + armourStatsBoost()
                      : state.eqList[id].item.armour,
                  attack: state.eqList[id].item.attack != null
                      ? state.eqList[id].item.attack! + attackStatsBoost()
                      : state.eqList[id].item.attack))
        else
          itemPlaceModel
    ]);
    if (state.eqList[id].classField != FieldTypeModel.backpack) {
      state = state.copywith(
          stats: state.stats.copywith(
              attack: state.eqList[id].item.attack == null
                  ? 0
                  : attackStatsBoost().toDouble(),
              armour: state.eqList[id].item.armour == null
                  ? 0
                  : armourStatsBoost().toDouble()));
    } else {
      state = state.copywith(stats: state.stats.copywith(attack: 0, armour: 0));
    }
    await ref.read(moneyProvider.notifier).subtractmoney(bill);
  }

  void ubracsie(int id) {
    if (state.eqList[id].isEmpty == false &&
        state.eqList[id].classField == FieldTypeModel.backpack) {
      ItemModel itemBeforeWear = state.eqList[id].item;
      state = state.copywith(
          eqList: [
            for (final itemPlaceModel in state.eqList)
              if (itemPlaceModel.classField == FieldTypeModel.helmet &&
                  state.eqList[id].item.classItem == ItemTypeModel.helmet &&
                  state.eqList[0].item.classItem == ItemTypeModel.none)
                itemPlaceModel.copywith(
                    isEmpty: false, item: state.eqList[id].item)
              else if (itemPlaceModel.classField == FieldTypeModel.chestplate &&
                  state.eqList[id].item.classItem == ItemTypeModel.chestplate &&
                  state.eqList[2].item.classItem == ItemTypeModel.none)
                itemPlaceModel.copywith(
                    isEmpty: false, item: state.eqList[id].item)
              else if (itemPlaceModel.classField == FieldTypeModel.sword &&
                  state.eqList[id].item.classItem == ItemTypeModel.sword &&
                  state.eqList[1].item.classItem == ItemTypeModel.none)
                itemPlaceModel.copywith(
                    isEmpty: false, item: state.eqList[id].item)
              else if (itemPlaceModel.classField == FieldTypeModel.pants &&
                  state.eqList[id].item.classItem == ItemTypeModel.pants &&
                  state.eqList[3].item.classItem == ItemTypeModel.none)
                itemPlaceModel.copywith(
                    isEmpty: false, item: state.eqList[id].item)
              else if (itemPlaceModel.classField == FieldTypeModel.boots &&
                  state.eqList[id].item.classItem == ItemTypeModel.boots &&
                  state.eqList[4].item.classItem == ItemTypeModel.none)
                itemPlaceModel.copywith(
                    isEmpty: false, item: state.eqList[id].item)
              else
                itemPlaceModel
          ],
          stats: state.stats.copywith(
              attack: (itemBeforeWear.attack ?? 0).toDouble(),
              armour: (itemBeforeWear.armour ?? 0).toDouble()));

      state = state.copywith(eqList: [
        for (final itemPlaceModel in state.eqList)
          if (itemPlaceModel.item != const ItemModel() &&
              itemPlaceModel.id == id)
            itemPlaceModel.copywith(isEmpty: true, item: const ItemModel())
          else
            itemPlaceModel,
      ]);
    }
  }

  void podmiankaItemow(int id) {
    if (state.eqList[id].isEmpty == false &&
        state.eqList[id].classField == FieldTypeModel.backpack) {
      ItemModel itemBeforePutOn = state.eqList[id].item;
      int idItemBeforeTakeOff = state.eqList
          .firstWhere(
              (e) =>
                  e.item.classItem == state.eqList[id].item.classItem &&
                  e.isEmpty == false &&
                  e.classField != FieldTypeModel.backpack,
              orElse: () => ItemPlaceModel(
                  id: -1,
                  isEmpty: true,
                  classField: FieldTypeModel.backpack,
                  item: const ItemModel()))
          .id;
      if (idItemBeforeTakeOff == -1) {
        return;
      }
      ItemModel itemBeforeTakeOff = state.eqList[idItemBeforeTakeOff].item;

      state = state.copywith(eqList: [
        for (final itemPlaceModel in state.eqList)
          if (itemPlaceModel.id == idItemBeforeTakeOff)
            itemPlaceModel.copywith(isEmpty: false, item: itemBeforePutOn)
          else if (itemPlaceModel.id == id)
            itemPlaceModel.copywith(isEmpty: false, item: itemBeforeTakeOff)
          else
            itemPlaceModel
      ]);

      state = state.copywith(
          stats: state.stats.copywith(
              attack: ((itemBeforeTakeOff.attack ?? 0).toDouble() * -1) +
                  (itemBeforePutOn.attack ?? 0).toDouble(),
              armour: ((itemBeforeTakeOff.armour ?? 0).toDouble() * -1) +
                  (itemBeforePutOn.armour ?? 0).toDouble()));
    }
  }

  void rozebracsie(int id) {
    double armour = 0;
    double attack = 0;

    if (state.eqList[id].isEmpty == false &&
        state.eqList[id].classField != FieldTypeModel.backpack) {
      armour -= (state.eqList[id].item.armour ?? 0).toDouble();
      attack -= (state.eqList[id].item.attack ?? 0).toDouble();

      ItemPlaceModel first = state.eqList.firstWhere(
          (e) => e.isEmpty && e.classField == FieldTypeModel.backpack);
      state = state.copywith(eqList: [
        for (final itemPlaceModel in state.eqList)
          if (itemPlaceModel.classField == FieldTypeModel.backpack &&
              itemPlaceModel.isEmpty == true &&
              itemPlaceModel.id == first.id)
            itemPlaceModel.copywith(isEmpty: false, item: state.eqList[id].item)
          else
            itemPlaceModel
      ]);
      state = state.copywith(eqList: [
        for (final itemPlaceModel in state.eqList)
          if (itemPlaceModel.classField == FieldTypeModel.helmet &&
              itemPlaceModel.id == id)
            itemPlaceModel.copywith(isEmpty: true, item: const ItemModel())
          else if (itemPlaceModel.classField == FieldTypeModel.chestplate &&
              itemPlaceModel.id == id)
            itemPlaceModel.copywith(isEmpty: true, item: const ItemModel())
          else if (itemPlaceModel.classField == FieldTypeModel.sword &&
              itemPlaceModel.id == id)
            itemPlaceModel.copywith(isEmpty: true, item: const ItemModel())
          else if (itemPlaceModel.classField == FieldTypeModel.pants &&
              itemPlaceModel.id == id)
            itemPlaceModel.copywith(isEmpty: true, item: const ItemModel())
          else if (itemPlaceModel.classField == FieldTypeModel.boots &&
              itemPlaceModel.id == id)
            itemPlaceModel.copywith(isEmpty: true, item: const ItemModel())
          else
            itemPlaceModel
      ], stats: state.stats.copywith(attack: (attack), armour: (armour)));
    }
  }

  void randomItemDropToEQ(int dropRate) {
    final item = eqRepo.getDrawnItem(dropRate);
    if (item == null) {
      return;
    }
    final firstFreeItemPlaceModel = state.eqList.firstWhere((element) =>
        element.isEmpty == true &&
        element.classField == FieldTypeModel.backpack);
    state = state.copywith(eqList: [
      for (final itemplaceModel in state.eqList)
        if (itemplaceModel.classField == FieldTypeModel.backpack &&
            itemplaceModel.isEmpty == true &&
            firstFreeItemPlaceModel.id == itemplaceModel.id)
          itemplaceModel.copywith(isEmpty: false, item: item)
        else
          itemplaceModel
    ]);
  }

  void deleteItem(int id) {
    double armour = 0;
    double attack = 0;

    if (state.eqList[id].isEmpty == false &&
        state.eqList[id].classField != FieldTypeModel.backpack) {
      armour -= (state.eqList[id].item.armour ?? 0).toDouble();
      attack -= (state.eqList[id].item.attack ?? 0).toDouble();
    }

    state = state.copywith(eqList: [
      for (final itemplaceModel in state.eqList)
        if (itemplaceModel.isEmpty == false && itemplaceModel.id == id)
          itemplaceModel.copywith(isEmpty: true, item: const ItemModel())
        else
          itemplaceModel
    ], stats: state.stats.copywith(attack: attack, armour: armour));
  }

  void deleteItems() {
    state = state.copywith(eqList: [
      for (final itemplaceModel in state.eqList)
        if (itemplaceModel.isEmpty == false)
          itemplaceModel.copywith(isEmpty: true, item: const ItemModel())
        else
          itemplaceModel
    ]);
  }

  int getIdItemBeforeTakeOff(int id) {
    return state.eqList
        .firstWhere((e) =>
            e.item.classItem == state.eqList[id].item.classItem &&
            e.isEmpty == false &&
            e.classField != FieldTypeModel.backpack)
        .id;
  }

  bool czyPustePole(int id) {
    return state.eqList[id].item.classItem == ItemTypeModel.helmet
        ? state.eqList[0].isEmpty
        : state.eqList[id].item.classItem == ItemTypeModel.chestplate
            ? state.eqList[2].isEmpty
            : state.eqList[id].item.classItem == ItemTypeModel.sword
                ? state.eqList[1].isEmpty
                : state.eqList[id].item.classItem == ItemTypeModel.pants
                    ? state.eqList[3].isEmpty
                    : state.eqList[4].isEmpty;
  }

  bool isSpace() {
    int fullPlace = 0;
    int allPlace = 0;
    for (final itemplaceModel in state.eqList) {
      if (itemplaceModel.classField == FieldTypeModel.backpack &&
          itemplaceModel.isEmpty == false) {
        fullPlace++;
      }
      if (itemplaceModel.classField == FieldTypeModel.backpack) allPlace++;
    }
    if (fullPlace == allPlace) {
      return false;
    }
    return true;
  }

  bool isMaxLevel(int id) {
    return eqRepo.isItemMaxLevel(
        state.eqList[id].item.itemLevel, state.eqList[id].item.itemRarity);
  }

  String getMaxLevel(String rarity) {
    return eqRepo.getMaxLevel(rarity);
  }

  int attackStatsBoost() => 1;
  int armourStatsBoost() => 1;
}
