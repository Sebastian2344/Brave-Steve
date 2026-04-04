import 'package:brave_steve/core/di/providers.dart';
import 'package:brave_steve/modules/save_game/model/save_model.dart';
import 'package:brave_steve/modules/save_game/repo/save_repository.dart';
import 'package:brave_steve/modules/game/state_menegment/action_button_state.dart';
import 'package:brave_steve/modules/counter_enemy_and_bioms/menagment/counter_enemy_state.dart';
import 'package:brave_steve/modules/game/state_menegment/effects_state.dart';
import 'package:brave_steve/modules/eq/menagment/eq_state.dart';
import 'package:brave_steve/modules/game/state_menegment/game_state.dart';
import 'package:brave_steve/modules/sounds/menagment/sound_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveStateNotifier extends Notifier<List<SaveModel>> {
  SaveRepository get saveRepositoryGame => ref.read(saveRepositoryProvider);
  @override
  List<SaveModel> build() {
    ref.watch(saveRepositoryProvider);
    return saveRepositoryGame.returnListSaves();
  }

  Future<void> saveGame(String name) async {
    ref.read(soundManagerProvider.notifier).playButtonClick();
    await saveRepositoryGame.addSaveGame(
        ref.read(myStateProvider).list,
        name,
        ref.read(providerEQ),
        ref.read(counterEnemyNotifierProvider),
        ref.read(myStateProvider).expMultiply);
    state = saveRepositoryGame.returnListSaves();
  }

  void loadSave(int index) {
    ref.read(soundManagerProvider.notifier).playButtonClick(); //sound
    ref
        .read(myStateProvider.notifier)
        .loadPlayerAndMobs(index); //player and enemies
    ref.read(providerEQ.notifier).loadItemPlaceModels(index); //eq
    ref
        .read(counterEnemyNotifierProvider.notifier)
        .fromSave(index); //enemy counter and set biom
    ref.read(myStateProvider.notifier).loadExpMultiply(index); //exp multiply
    ref
        .read(effectsStateProvider.notifier)
        .setEffects(); // efects(weakness,clearance)
    ref
        .read(actionButtonIgnoreProvider.notifier)
        .setAfterplayerAndEneyLoad(); //action buttons state
  }

  void returnListSaves() {
    state = saveRepositoryGame.returnListSaves();
  }

  void removeSave(int index) {
    saveRepositoryGame.removeSave(index);
    state = saveRepositoryGame.returnListSaves();
  }
}

final saveStateProvider =
    NotifierProvider<SaveStateNotifier, List<SaveModel>>(() {
  return SaveStateNotifier();
});
