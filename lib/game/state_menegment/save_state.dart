import 'package:brave_steve/game/data_layer/models/save_model/save_model.dart';
import 'package:brave_steve/game/data_layer/repo/save_repository.dart';
import 'package:brave_steve/game/state_menegment/counter_enemy_state.dart';
import 'package:brave_steve/game/state_menegment/eq_state.dart';
import 'package:brave_steve/game/state_menegment/game_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveStateNotifier extends Notifier<List<SaveModel>> {

  SaveRepository get saveRepositoryGame => ref.read(saveRepositoryProvider);
  @override
  List<SaveModel> build() {
    ref.watch(saveRepositoryProvider);
    return saveRepositoryGame.returnListSaves();
  }

  Future<void> saveGame(String name) async {
    await saveRepositoryGame.addSaveGame(
        ref.read(myStateProvider).list,
        name,
        ref.read(providerEQ),
        ref.read(counterEnemyNotifierProvider),
        ref.read(myStateProvider).expMultiply);
    state = saveRepositoryGame.returnListSaves();
  }

  void returnListSaves() {
    state = saveRepositoryGame.returnListSaves();
  }

  void removeSave(int index) {
    saveRepositoryGame.removeSave(index);
    state = saveRepositoryGame.returnListSaves();
  }
}

final saveStateProvider = NotifierProvider<SaveStateNotifier, List<SaveModel>>(() {return SaveStateNotifier();});