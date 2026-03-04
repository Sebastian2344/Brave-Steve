import 'dart:math';
import 'package:brave_steve/game/data_layer/models/my_vars_model/my_vars_model.dart';
import 'package:brave_steve/game/data_layer/repo/repository.dart';
import 'package:brave_steve/game/state_menegment/action_button_state.dart';
import 'package:brave_steve/game/state_menegment/effects_state.dart';
import 'package:brave_steve/game/state_menegment/eq_state.dart';
import 'package:brave_steve/game/state_menegment/counter_enemy_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data_layer/models/player_model/player_model.dart';
import '../data_layer/models/player_model/steve.dart';

enum Stan { koniecGry, wygrana, przegrana, graTrwa, graNieRozpoczeta }

class GameState extends Notifier<MyVars> {
  RepositoryGame get repositoryGame => ref.read(repoProvider);
  @override
  build() {
    ref.watch(repoProvider);
    return MyVars(
        move1: false,
        move2: false,
        list: repositoryGame.playersStartStatsasPlayerModelList(),
        enemyIndex: 1,
        expMultiply: 1,
        gameState: Stan.graNieRozpoczeta);
  }

  Future<void> newGame() async {
    ref.read(actionButtonIgnoreProvider.notifier).reset();
    await repositoryGame.openGameDB();
    List<PlayerModel> l = await repositoryGame.listPlayerToListPlayerModel();
    ref.read(effectsStateProvider.notifier).clearEffects();
    state = state.copyWith(
        list: l, enemyIndex: 1, expMultiply: 1, gameState: Stan.graTrwa);
  }

  void gameOver() {
    ref.read(actionButtonIgnoreProvider.notifier).reset();
    ref.read(effectsStateProvider.notifier).clearEffects();
    state = state.copyWith(
        move1: false,
        move2: false,
        list: repositoryGame.playersStartStatsasPlayerModelList(),
        enemyIndex: 1,
        expMultiply: 1,
        gameState: Stan.graNieRozpoczeta);
  }

  void loadPlayerAndMobs(int index) {
    final players = repositoryGame.getPlayersfromDBasPlayerModelList(index);
    if (players.isNotEmpty) {
      ref.read(effectsStateProvider.notifier).clearEffects();
      ref
          .read(effectsStateProvider.notifier)
          .setWeaknessPlayer(players[0].isWeak());
      ref.read(effectsStateProvider.notifier).setWeaknessEnemy(
          players[(players[0] as Steve).getEnemyIndex()].isWeak());
      state = state.copyWith(
        list: players,
        enemyIndex: (players[0] as Steve).getEnemyIndex(),
      );
    }
  }

  void loadExpMultiply(int index) {
    final expMultiply = repositoryGame.loadExpMultiple(index);
    state = state.copyWith(expMultiply: expMultiply);
  }

  Future<void> closeGameDB() async {
    await repositoryGame.closeGameDB();
  }

  Future<void> openGameDB() async {
    await repositoryGame.openGameDB();
  }

  Future<Enum> battle({
    required bool superAtack,
    required bool cleary,
    required bool weakOnEnemy,
  }) async {
    if (state.list[0].isLive() && state.list[state.enemyIndex].isLive()) {
      _firstPlayerCome(cleary);
      await Future.delayed(const Duration(milliseconds: 500));
      _hit(superAtack, cleary, weakOnEnemy);
      await Future.delayed(const Duration(milliseconds: 500));
    }
    if (state.list[state.enemyIndex].isLive() && state.list[0].isLive()) {
      int option = _enemyCome();
      await Future.delayed(const Duration(milliseconds: 500));
      _enemyTurn(option);
      await Future.delayed(const Duration(milliseconds: 500));
    }
    if (!state.list[0].isLive() || !state.list[state.enemyIndex].isLive()) {
      ref.read(actionButtonIgnoreProvider.notifier).reset();
      if (ref.read(counterEnemyNotifierProvider).enemyCounter == 400) {
        return Stan.koniecGry;
      } else {
        if (state.list[0].isLive()) {
          return Stan.wygrana;
        }
        return Stan.przegrana;
      }
    }
    return Stan.graTrwa;
  }

  bool isEq() {
    return state.list[state.enemyIndex].showHp() ==
            state.list[state.enemyIndex].maxHpInfo() &&
        state.list[state.enemyIndex].getMaxArmour() ==
            state.list[state.enemyIndex].getArmour();
  }

  void setStats() {
    final record = ref.read(providerEQ).stats;
    state.list[0].setArmour = record.armour + state.list[0].getArmour();
    state.list[0].setMaxArmour = record.armour + state.list[0].getMaxArmour();
    state.list[0].setAttack = record.attack + state.list[0].getMaxAttack();
    state.list[0].setMaxAttack = record.attack + state.list[0].getMaxAttack();
    state = state.copyWith(
      list: [
        state.list[0],
        ...state.list.sublist(1)
      ],
    );
  }

  void setStatsPlayerAndEnemyAfterWin() {
    int bossIndex = ref.read(counterEnemyNotifierProvider).boss;
    ref.read(effectsStateProvider.notifier).clearEffects();
    state.list[0].addExpirience(state.expMultiply, 50);
    if (state.list[0].showExp() == 100) {
      state = state.copyWith(list: [
        state.list[0].setPlayerAgain().levelUp(),
        ...state.list.sublist(1)
      ]);
    }
    state = state.copyWith(
        list: [
          state.list[0].setPlayerAgain(),
          ...state.list.sublist(1).map((element) => element.levelUp())
        ],
        move2: false,
        enemyIndex: _setEnemyIndex(state.enemyIndex, bossIndex));
    (state.list[0] as Steve).setEnemyIndex(state.enemyIndex);
  }

  void setStatsAfterLose() {
    ref.read(effectsStateProvider.notifier).clearEffects();
    final listPlayer = repositoryGame.playersStartStatsasPlayerModelList();
    listPlayer[0] = state.list[0].setPlayerAgain();
    state = state.copyWith(
        list: listPlayer,
        enemyIndex: 1,
        move2: false,
        expMultiply: 1);
    (state.list[0] as Steve).setEnemyIndex(state.enemyIndex);
  }

//===================================================================================//
  // Private Methods
//===================================================================================//

  int _setEnemyIndex(int index, int bossIndex) {
    if (index > 0 + 3 * bossIndex &&
        index < 3 + 3 * bossIndex &&
        index < state.list.length - 1) {
      index += 1;
    } else {
      index = 1;
    }
    
    return index;
  }

  void _firstPlayerCome(bool cleary) {
    ref.read(effectsStateProvider.notifier).setClearenceForAll(false);
    state = state.copyWith(
        move1: cleary ? false : true);
    ref.read(actionButtonIgnoreProvider.notifier).setAllIgnore();
  }

  void _hit(bool superAtack, bool cleary, bool weakOnEnemy) {
    if (superAtack) {
      state.list[0].makeSuperAttack(state.list[state.enemyIndex]);
    } else if (cleary) {
      state.list[0].clearMe();
      ref.read(effectsStateProvider.notifier).setAllEffects(false,true, false, ref.read(effectsStateProvider).isWeaknessEnemy);
    } else if (weakOnEnemy && !state.list[state.enemyIndex].isWeak()) {
      state.list[0].weakness(state.list[state.enemyIndex]);
      ref.read(effectsStateProvider.notifier).setAllEffects(ref.read(effectsStateProvider).isWeaknessPlayer, false, false, true);
    } else {
      state.list[0].makeAttack(state.list[state.enemyIndex]);
    }
    state = state.copyWith(move1: false);
  }

  int _enemyCome() {
    ref.read(effectsStateProvider.notifier).setClearenceForAll(false);
    int option = Random().nextInt(3);
    option == 0 || option == 2
        ? state = state.copyWith(move2: true)
        : state.list[state.enemyIndex].isWeak() &&
                state.list[state.enemyIndex].showMana() >=
                    state.list[state.enemyIndex].showManaCost('clearMe')
            ? state = state.copyWith(move2: false)
            : state = state.copyWith(move2: true);

    return option;
  }

  void _enemyTurn(int option) {
    if (option == 0) {
      if (state.list[state.enemyIndex].showMana() >=
          state.list[state.enemyIndex].showManaCost('SuperAttack')) {
        state.list[state.enemyIndex].makeSuperAttack(state.list[0]);
      } else {
        state.list[state.enemyIndex].makeAttack(state.list[0]);
      }
    } else if (option == 1) {
      {
        if (state.list[state.enemyIndex].isWeak() &&
            state.list[state.enemyIndex].showMana() >=
                state.list[state.enemyIndex].showManaCost('clearMe')) {
          state.list[state.enemyIndex].clearMe();
          ref.read(effectsStateProvider.notifier).setAllEffects(ref.read(effectsStateProvider).isWeaknessPlayer, false, true, false);
        } else {
          int newOption = Random().nextInt(3);
          if (newOption != option) {
            _enemyTurn(newOption);
          } else {
            state.list[state.enemyIndex].makeAttack(state.list[0]);
          }
        }
      }
    } else if (option == 2) {
      {
        if (!state.list[0].isWeak() &&
            state.list[state.enemyIndex].showMana() >=
                state.list[state.enemyIndex].showManaCost('weakness')) {
          state.list[state.enemyIndex].weakness(state.list[0]);
          ref.read(effectsStateProvider.notifier).setClearenceForAll(false);
          ref.read(effectsStateProvider.notifier).setWeaknessPlayer(true);
        } else {
          int newOption = Random().nextInt(3);
          if (newOption != option) {
            _enemyTurn(newOption);
          } else {
            state.list[state.enemyIndex].makeAttack(state.list[0]);
          }
        }
      }
    }
    state = state.copyWith(move2: false);
    _setButtonsbuttonIgnore();
  }

  void _setButtonsbuttonIgnore() {
    if (state.list[0].showMana() >= state.list[0].showManaCost('SuperAttack')) {
      ref.read(actionButtonIgnoreProvider.notifier).changeSuperAtack(false);
    }
    if (state.list[0].showMana() >= state.list[0].showManaCost('weakness')) {
      ref.read(actionButtonIgnoreProvider.notifier).changeWeakOnEnemy(false);
    }
    if (state.list[0].showMana() >= state.list[0].showManaCost('clearMe')) {
      ref.read(actionButtonIgnoreProvider.notifier).changeCleary(false);
    }
    ref.read(actionButtonIgnoreProvider.notifier).changeAtack(false);
  }
}

final myStateProvider = NotifierProvider<GameState, MyVars>(() {
  return GameState();
});
