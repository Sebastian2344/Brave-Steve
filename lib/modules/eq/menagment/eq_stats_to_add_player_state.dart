import 'package:brave_steve/modules/eq/model/stats_model_to_add_stats_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EqStatsToAddPlayerState extends Notifier<StatsModelToAddStatsPlayer> {
  @override
  build() {
    return const StatsModelToAddStatsPlayer(armour: 0, attack: 0);
  }

  void upgradeWearItem(int? attack, int? armour, double attackBoost, double armourBoost) {
    state = state.copywith(
        attack: attack == null ? 0 : attackBoost,
        armour: armour == null ? 0 : armourBoost);
  }

  void wearItem(int? attack, int? armour) {
    state = state.copywith(
        armour: (armour ?? 0).toDouble(), attack: (attack ?? 0).toDouble());
  }

  void takeOffItem(int? attack, int? armour) {
    state = state.copywith(
        armour: 0 - (armour ?? 0).toDouble(),
        attack: 0 - (attack ?? 0).toDouble());
  }

  void podmianka(int? attack, int? armour) {
     state = state.copywith(
        armour: (armour ?? 0).toDouble(),
        attack: (attack ?? 0).toDouble());
  }

  void deleteWearItem(int? attack, int? armour) {
    state = state.copywith(
        armour: 0 - (armour ?? 0).toDouble(),
        attack: 0 - (attack ?? 0).toDouble());
  }

  void reset() {
    state = state.copywith(armour: 0, attack: 0);
  }
}

final eqStatsToAddPlayerStateProvider =
    NotifierProvider<EqStatsToAddPlayerState, StatsModelToAddStatsPlayer>(() {
  return EqStatsToAddPlayerState();
});
