import 'package:brave_steve/core/di/providers.dart';
import 'package:brave_steve/modules/game/state_menegment/game_state.dart';
import 'package:brave_steve/modules/prestige/prestige_model.dart';
import 'package:brave_steve/modules/prestige/prestige_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrestigeNotifier extends Notifier<PrestigeModel> {
  PrestigeRepo get prestigeRepo => ref.read(prestigeRepoProvider);

  @override
  build() {
    ref.watch(prestigeRepoProvider);
    return const PrestigeModel(
        points: 0,
        attack: 0,
        health: 0,
        isGivePoints: false,
        lucky: 0,
        calculatedPoints: 0);
  }

  void fromSave(int index) {
    state = prestigeRepo.fromDb();
  }

  void incrementAttack() {
    state = state.copywith(points: state.points - 1, attack: state.attack + 1);
  }

  void incrementHealth() {
    state = state.copywith(points: state.points - 1, health: state.health + 10);
  }

  void incrementLucky() {
    state = state.copywith(points: state.points - 1, lucky: state.lucky + 0.25);
  }

  Future<void> savePrestige() async {
    await prestigeRepo.saveToDb(state);
    ref.read(myStateProvider.notifier).prestigeGame();
  }

  void calculatedPoints(int level) {
    int calPonts = prestigeRepo.calculatePoints(level);
    state = state.copywith(calculatedPoints: calPonts);
  }

  void stepBack() {
    final xd = prestigeRepo.fromDb();
    state = state.copywith(
        points: 0,
        isGivePoints: false,
        attack: xd.attack,
        health: xd.health,
        lucky: xd.lucky);
  }

  void resetPoints(int level) {
    int points = prestigeRepo.calculatePoints(level);
    final xd = prestigeRepo.fromDb();
    state = state.copywith(
        points: points,
        isGivePoints: true,
        attack: xd.attack,
        health: xd.health,
        lucky: xd.lucky);
  }

  void givePoints(int level) {
    int points = prestigeRepo.calculatePoints(level);
    state = state.copywith(points: points, isGivePoints: true);
  }
}

final prestigeNotifierProvider =
    NotifierProvider<PrestigeNotifier, PrestigeModel>(() {
  return PrestigeNotifier();
});
