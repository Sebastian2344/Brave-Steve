import 'package:brave_steve/modules/prestige/prestige.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PrestigeData {
  Future<void> saveToDb(Prestige prestige) async {
    await Hive.box<Prestige>('prestige').put(0, prestige);
  }

  Prestige getData() {
    return Hive.box<Prestige>('prestige').isEmpty
        ? Prestige(attack: 0, health: 0, points: 0)
        : Hive.box<Prestige>('prestige').getAt(0) ?? Prestige(attack: 0, health: 0, points: 0);
  }
}
