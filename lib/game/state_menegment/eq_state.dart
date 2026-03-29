import 'package:brave_steve/game/data_layer/repo/eq_repo.dart';
import 'package:brave_steve/game/state_menegment/eq_stats_to_add_player_state.dart';
import 'package:brave_steve/game/state_menegment/merge_item_state.dart';
import 'package:brave_steve/game/state_menegment/money_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data_layer/models/eq_model/eq_model.dart';

final providerEQ = NotifierProvider<EqStateMenagment, List<ItemPlaceModel>>(() {
  return EqStateMenagment();
});

class EqStateMenagment extends Notifier<List<ItemPlaceModel>> {
  EqRepo get eqRepo => ref.read(eqRepoProvider);

  @override
  build() {
    ref.watch(eqRepoProvider);
    return [
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
    ];
  }

  void loadItemPlaceModels(int index) {
    List<ItemPlaceModel> o = eqRepo.getListFieldTypeModelFromDB(index);
    state = [for (final itemPlaceModel in o) itemPlaceModel];
  }

  void addItemToEQ() {
    final itemM = ref.read(providerMergeItem)[2];
    ItemModel item = ItemModel(
        name: itemM.name,
        description: itemM.description,
        image: itemM.image,
        attack: itemM.attack,
        armour: itemM.armour,
        classItem: itemM.classItem,
        price: itemM.price,
        itemLevel: itemM.itemLevel,
        upgradePrice: itemM.upgradePrice,
        itemRarity: itemM.itemRarity);
    final firstFreeItemPlaceModel = state.firstWhere((element) =>
        element.isEmpty == true &&
        element.classField == FieldTypeModel.backpack);
    state = [
      for (final itemplaceModel in state)
        if (itemplaceModel.classField == FieldTypeModel.backpack &&
            itemplaceModel.isEmpty == true &&
            firstFreeItemPlaceModel.id == itemplaceModel.id)
          itemplaceModel.copywith(isEmpty: false, item: item)
        else
          itemplaceModel
    ];
  }

  Future<void> upgradeItem(int id, double money) async {
    if (money < state[id].item.upgradePrice) {
      return;
    }
    double bill = state[id].item.upgradePrice.toDouble();
    if (eqRepo.isItemMaxLevel(
        state[id].item.itemLevel, state[id].item.itemRarity)) {
      return;
    }
    state = [
      for (final itemPlaceModel in state)
        if (itemPlaceModel.id == id)
          itemPlaceModel.copywith(
              item: state[id].item.copywith(
                  itemLevel: state[id].item.itemLevel + 1,
                  upgradePrice: state[id].item.upgradePrice + 20,
                  armour: state[id].item.armour != null
                      ? state[id].item.armour! + armourStatsBoost()
                      : state[id].item.armour,
                  attack: state[id].item.attack != null
                      ? state[id].item.attack! + attackStatsBoost()
                      : state[id].item.attack))
        else
          itemPlaceModel
    ];
    if (state[id].classField != FieldTypeModel.backpack) {
      ref.read(eqStatsToAddPlayerStateProvider.notifier).upgradeWearItem(
          state[id].item.attack,
          state[id].item.armour,
          attackStatsBoost().toDouble(),
          armourStatsBoost().toDouble());
    } else {
      ref.read(eqStatsToAddPlayerStateProvider.notifier).reset();
    }
    await ref.read(moneyProvider.notifier).subtractmoney(bill);
  }

  void ubracsie(int id) {
    if (state[id].isEmpty == false &&
        state[id].classField == FieldTypeModel.backpack) {
      ItemModel itemBeforeWear = state[id].item;
      state = [
          for (final itemPlaceModel in state)
            if (itemPlaceModel.classField == FieldTypeModel.helmet &&
                state[id].item.classItem == ItemTypeModel.helmet &&
                state[0].item.classItem == ItemTypeModel.none)
              itemPlaceModel.copywith(
                  isEmpty: false, item: state[id].item)
            else if (itemPlaceModel.classField == FieldTypeModel.chestplate &&
                state[id].item.classItem == ItemTypeModel.chestplate &&
                state[2].item.classItem == ItemTypeModel.none)
              itemPlaceModel.copywith(
                  isEmpty: false, item: state[id].item)
            else if (itemPlaceModel.classField == FieldTypeModel.sword &&
                state[id].item.classItem == ItemTypeModel.sword &&
                state[1].item.classItem == ItemTypeModel.none)
              itemPlaceModel.copywith(
                  isEmpty: false, item: state[id].item)
            else if (itemPlaceModel.classField == FieldTypeModel.pants &&
                state[id].item.classItem == ItemTypeModel.pants &&
                state[3].item.classItem == ItemTypeModel.none)
              itemPlaceModel.copywith(
                  isEmpty: false, item: state[id].item)
            else if (itemPlaceModel.classField == FieldTypeModel.boots &&
                state[id].item.classItem == ItemTypeModel.boots &&
                state[4].item.classItem == ItemTypeModel.none)
              itemPlaceModel.copywith(
                  isEmpty: false, item: state[id].item)
            else
              itemPlaceModel
        ];

      ref
          .read(eqStatsToAddPlayerStateProvider.notifier)
          .wearItem(itemBeforeWear.attack, itemBeforeWear.armour);

      state = [
        for (final itemPlaceModel in state)
          if (itemPlaceModel.item != const ItemModel() &&
              itemPlaceModel.id == id)
            itemPlaceModel.copywith(isEmpty: true, item: const ItemModel())
          else
            itemPlaceModel,
      ];
    }
  }

  void podmiankaItemow(int id) {
    if (state[id].isEmpty == false &&
        state[id].classField == FieldTypeModel.backpack) {
      ItemModel itemBeforePutOn = state[id].item;
      int idItemBeforeTakeOff = state
          .firstWhere(
              (e) =>
                  e.item.classItem == state[id].item.classItem &&
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
      ItemModel itemBeforeTakeOff = state[idItemBeforeTakeOff].item;

      state = [
        for (final itemPlaceModel in state)
          if (itemPlaceModel.id == idItemBeforeTakeOff)
            itemPlaceModel.copywith(isEmpty: false, item: itemBeforePutOn)
          else if (itemPlaceModel.id == id)
            itemPlaceModel.copywith(isEmpty: false, item: itemBeforeTakeOff)
          else
            itemPlaceModel
      ];

      ref.read(eqStatsToAddPlayerStateProvider.notifier).podmianka(
          ((itemBeforeTakeOff.attack ?? 0) * -1) +
              (itemBeforePutOn.attack ?? 0),
          ((itemBeforeTakeOff.armour ?? 0) * -1) +
              (itemBeforePutOn.armour ?? 0));

    }
  }

  void rozebracsie(int id) {
    if (state[id].isEmpty == false &&
        state[id].classField != FieldTypeModel.backpack) {
      ref.read(eqStatsToAddPlayerStateProvider.notifier).takeOffItem(
          state[id].item.attack, state[id].item.armour);

      ItemPlaceModel first = state.firstWhere(
          (e) => e.isEmpty && e.classField == FieldTypeModel.backpack);
      state = [
        for (final itemPlaceModel in state)
          if (itemPlaceModel.classField == FieldTypeModel.backpack &&
              itemPlaceModel.isEmpty == true &&
              itemPlaceModel.id == first.id)
            itemPlaceModel.copywith(isEmpty: false, item: state[id].item)
          else
            itemPlaceModel
      ];
      state = [
        for (final itemPlaceModel in state)
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
      ];
    }
  }

  void randomItemDropToEQ(int dropRate) {
    final item = eqRepo.getDrawnItem(dropRate);
    if (item == null || isSpace() == false) {
      return;
    }
    final firstFreeItemPlaceModel = state.firstWhere((element) =>
        element.isEmpty == true &&
        element.classField == FieldTypeModel.backpack);
    state = [
      for (final itemplaceModel in state)
        if (itemplaceModel.classField == FieldTypeModel.backpack &&
            itemplaceModel.isEmpty == true &&
            firstFreeItemPlaceModel.id == itemplaceModel.id)
          itemplaceModel.copywith(isEmpty: false, item: item)
        else
          itemplaceModel
    ];
  }

  void delete2Items() {
    final item1 = ref.read(providerMergeItem)[0];
    final item2 = ref.read(providerMergeItem)[1];

    state = [
      for (final itemPlaceModel in state)
        if (itemPlaceModel.id == item1.fromEQId ||
            itemPlaceModel.id == item2.fromEQId)
          itemPlaceModel.copywith(isEmpty: true, item: const ItemModel())
        else
          itemPlaceModel
    ];
  }

  void deleteItem(int id) {
    if (state[id].isEmpty == false &&
        state[id].classField != FieldTypeModel.backpack) {
      ref.read(eqStatsToAddPlayerStateProvider.notifier).deleteWearItem(
          state[id].item.attack, state[id].item.armour);
    }

    state = [
      for (final itemplaceModel in state)
        if (itemplaceModel.isEmpty == false && itemplaceModel.id == id)
          itemplaceModel.copywith(isEmpty: true, item: const ItemModel())
        else
          itemplaceModel
    ];
  }

  void deleteItems() {
    state = [
      for (final itemplaceModel in state)
        if (itemplaceModel.isEmpty == false)
          itemplaceModel.copywith(isEmpty: true, item: const ItemModel())
        else
          itemplaceModel
    ];
  }

  int getIdItemBeforeTakeOff(int id) {
    return state
        .firstWhere((e) =>
            e.item.classItem == state[id].item.classItem &&
            e.isEmpty == false &&
            e.classField != FieldTypeModel.backpack)
        .id;
  }

  bool czyPustePole(int id) {
    return state[id].item.classItem == ItemTypeModel.helmet
        ? state[0].isEmpty
        : state[id].item.classItem == ItemTypeModel.chestplate
            ? state[2].isEmpty
            : state[id].item.classItem == ItemTypeModel.sword
                ? state[1].isEmpty
                : state[id].item.classItem == ItemTypeModel.pants
                    ? state[3].isEmpty
                    : state[4].isEmpty;
  }

  bool isSpace() {
    int fullPlace = 0;
    int allPlace = 0;
    for (final itemplaceModel in state) {
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
        state[id].item.itemLevel, state[id].item.itemRarity);
  }

  String getMaxLevel(String rarity) {
    return eqRepo.getMaxLevel(rarity);
  }

  int attackStatsBoost() => 1;
  int armourStatsBoost() => 1;
}
