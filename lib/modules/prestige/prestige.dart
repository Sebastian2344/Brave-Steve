

import 'package:brave_steve/modules/prestige/prestige_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'prestige.g.dart';

@HiveType(typeId: 7)
class Prestige {
  @HiveField(0,defaultValue: 0)
  final int points;
  @HiveField(1,defaultValue: 0.0)
  final double attack;
  @HiveField(2,defaultValue: 0.0)
  final double health;

  const Prestige({required this.attack,required this.health,required this.points});

  PrestigeModel toPrestigeModel() {
    return PrestigeModel(points: points,attack: attack,health: health,isGivePoints: false);
  }

  static Prestige toPrestige(PrestigeModel model) {
    return Prestige(
      points: model.points,
      attack: model.attack,
      health: model.health,
    );
  }
}