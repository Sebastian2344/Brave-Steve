import 'dart:math';
import 'package:brave_steve/game/data_layer/models/save_model/save_model.dart';
import 'package:brave_steve/game/data_layer/repo/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data_layer/models/eq_model/eq_model.dart';
import '../data_layer/models/player_model/player_model.dart';
import '../data_layer/models/player_model/steve.dart';

enum Stan { koniecGry, wygrana, przegrana, graTrwa, graNieRozpoczeta }

class MyVars extends Equatable {
  final bool move1; //left side move
  final bool move2; //right side move
  final List<bool>
      buttonIgnore; //can press button or not - [atack, superatack,  weakness, clear]
  final List<PlayerModel>
      list; // player (index 0)and enemies(indexes 1 to 5) and bosses (index 6 and 7)
  final List<bool>
      heroEffect; //index 0(left player) 1(right player) weakness,index 2(left player) 3(right player) clearance
  final bool arrowGo; //skeleton arrow
  final int enemyIndex; //enemy player index
  final int skillPoints; //player skill points
  final Enum gameState;

  const MyVars(
      {required this.move1,
      required this.move2,
      required this.buttonIgnore,
      required this.list,
      required this.heroEffect,
      required this.enemyIndex,
      required this.arrowGo,
      required this.skillPoints,
      required this.gameState});

  MyVars copyWith(
      {final bool? move1,
      final bool? move2,
      final List<bool>? buttonIgnore,
      final List<PlayerModel>? list,
      final List<bool>? heroEffect,
      final int? enemyIndex,
      final bool? arrowGo,
      final int? skillPoints,
      final Enum? gameState}) {
    return MyVars(
        move1: move1 ?? this.move1,
        move2: move2 ?? this.move2,
        buttonIgnore: buttonIgnore ?? this.buttonIgnore,
        list: list ?? this.list,
        heroEffect: heroEffect ?? this.heroEffect,
        enemyIndex: enemyIndex ?? this.enemyIndex,
        arrowGo: arrowGo ?? this.arrowGo,
        skillPoints: skillPoints ?? this.skillPoints,
        gameState: gameState ?? this.gameState);
  }

  @override
  List<Object?> get props => [
        move1,
        move2,
        buttonIgnore,
        list,
        heroEffect,
        enemyIndex,
        arrowGo,
        skillPoints,
        gameState
      ];
}

class GameState extends StateNotifier<MyVars> {
  final RepositoryGame repositoryGame;
  GameState({required this.repositoryGame})
      : super(MyVars(
            move1: false,
            move2: false,
            buttonIgnore: const [false, false, false, false],
            list: repositoryGame.playersStartStatsasPlayerModelList(),
            heroEffect: const [false, false, false, false],
            enemyIndex: 1,
            arrowGo: false,
            skillPoints: 5,
            gameState: Stan.graNieRozpoczeta));

  Future<void> newGame() async {
    const List<bool> defaultSetList = [false, false, false, false];
    await repositoryGame.openGameDB();
    List<PlayerModel> l = await repositoryGame.listPlayerToListPlayerModel();
    state = state.copyWith(
        list: l,
        buttonIgnore: defaultSetList,
        heroEffect: defaultSetList,
        enemyIndex: 1,
        gameState: Stan.graTrwa);
  }

  void gameOver() {
    state = state.copyWith(
        move1: false,
        move2: false,
        buttonIgnore: const [false, false, false, false],
        list: repositoryGame.playersStartStatsasPlayerModelList(),
        heroEffect: const [false, false, false, false],
        enemyIndex: 1,
        arrowGo: false,
        skillPoints: 5,
        gameState: Stan.graNieRozpoczeta);
  }

  void loadPlayerAndMobs(int index) {
    final players = repositoryGame.getPlayersfromDBasPlayerModelList(index);
    if (players.isNotEmpty) {
      state = state.copyWith(
          list: players,
          heroEffect: [
            players[0].isWeak(),
            players[(players[0] as Steve).getEnemyIndex()].isWeak(),
            false,
            false
          ],
          enemyIndex: (players[0] as Steve).getEnemyIndex());
    }
  }

  Future<void> saveGame(String name, List<ItemPlaceModel> itemList) async {
    (state.list[0] as Steve).setEnemyIndex(state.enemyIndex);
    await repositoryGame.addSaveGame(state.list, name, itemList);
  }

  Future<void> closeGameDB() async {
    await repositoryGame.closeGameDB();
  }

  Future<void> openGameDB() async {
    await repositoryGame.openGameDB();
  }

  List<SaveModel> returnListSaves() {
    return repositoryGame.returnListSaves();
  }

  void removeSave(int index) {
    repositoryGame.removeSave(index);
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
      state = state.copyWith(arrowGo: true);
      await Future.delayed(const Duration(milliseconds: 500));
      state = state.copyWith(arrowGo: false);
      _enemyTurn(option);
      await Future.delayed(const Duration(milliseconds: 500));
    }
    if (!state.list[0].isLive() || !state.list[state.enemyIndex].isLive()) {
      state = state.copyWith(buttonIgnore: [false, false, false, false]);
      if (state.list[0].getlvl() == 10) {
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

  bool isLevelUp() {
    return state.list[0].showExp() == 100;
  }

  void chooseStats(int attack, int hp) {
    state = state.copyWith(list: [
      (state.list[0] as Steve).growStatsMyHero(attack, hp),
      state.list[1],
      state.list[2],
      state.list[3],
      state.list[4],
      state.list[5],
      state.list[6],
      state.list[7]
    ], skillPoints: state.skillPoints - 1);
  }

  void levelUp() {
    if (state.list[0].showExp() == 100) {
      state = state.copyWith(
          list: [
            state.list[0].levelUp(),
            state.list[1].levelUp(),
            state.list[2].levelUp(),
            state.list[3].levelUp(),
            state.list[4].levelUp(),
            state.list[5].levelUp(),
            state.list[6],
            state.list[7]
          ],
          heroEffect: [
            false,
            false,
            false,
            false
          ],
          skillPoints: 5,
          enemyIndex: state.list[0].getlvl() == 5
              ? 6
              : state.list[0].getlvl() == 10
                  ? 7
                  : _setEnemyIndex(state.enemyIndex));
    }
  }

  int lvl() {
    return state.list[0].getlvl();
  }

  void setStats((double, double) record) {
    state.list[0].setArmour = record.$1 + state.list[0].getArmour();
    state.list[0].setMaxArmour = record.$1 + state.list[0].getMaxArmour();
    state.list[0].setAttack = record.$2 + state.list[0].getMaxAttack();
    state.list[0].setMaxAttack = record.$2 + state.list[0].getMaxAttack();
  }

  void winnerOrLoser(bool win) {
    const List<bool> effects = [false, false, false, false];
    win
        ? {
            if (state.list[0].showExp() != 100)
              {
                state.list[0].addExpirience(),
                state = state.copyWith(
                    heroEffect: effects,
                    list: [
                      state.list[0].setPlayerAgain(),
                      state.list[1].setPlayerAgain(),
                      state.list[2].setPlayerAgain(),
                      state.list[3].setPlayerAgain(),
                      state.list[4].setPlayerAgain(),
                      state.list[5].setPlayerAgain(),
                      state.list[6],
                      state.list[7]
                    ],
                    move2: false)
              },
            if (state.list[0].showExp() != 100)
              {
                state =
                    state.copyWith(enemyIndex: _setEnemyIndex(state.enemyIndex))
              }
          }
        : {
            state = state.copyWith(
                list: repositoryGame.playersStartStatsasPlayerModelList(),
                heroEffect: effects,
                enemyIndex: 1,
                move2: false)
          };
  }

//===================================================================================//
  // Private Methods
//===================================================================================//
  int _setEnemyIndex(int index) {
    if (index > 0 && index < state.list.length - 3) {
      index += 1;
    } else {
      index = 1;
    }
    return index;
  }

  void _firstPlayerCome(bool cleary) {
    state = state.copyWith(
        heroEffect: [state.heroEffect[0], state.heroEffect[1], false, false],
        buttonIgnore: [true, true, true, true],
        move1: cleary ? false : true);
  }

  void _hit(bool superAtack, bool cleary, bool weakOnEnemy) {
    if (superAtack) {
      state.list[0].makeSuperAttack(state.list[state.enemyIndex]);
    } else if (cleary) {
      state.list[0].clearMe();
      state =
          state.copyWith(heroEffect: [false, state.heroEffect[1], true, false]);
    } else if (weakOnEnemy && !state.list[state.enemyIndex].isWeak()) {
      state.list[0].weakness(state.list[state.enemyIndex]);
      state =
          state.copyWith(heroEffect: [state.heroEffect[0], true, false, false]);
    } else {
      state.list[0].makeAttack(state.list[state.enemyIndex]);
    }
    state = state.copyWith(move1: false);
  }

  int _enemyCome() {
    state = state.copyWith(
        heroEffect: [state.heroEffect[0], state.heroEffect[1], false, false]);
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
          state = state
              .copyWith(heroEffect: [state.heroEffect[0], false, false, true]);
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
          state = state
              .copyWith(heroEffect: [true, state.heroEffect[1], false, false]);
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
      state = state.copyWith(buttonIgnore: [
        false,
        false,
        state.buttonIgnore[2],
        state.buttonIgnore[3]
      ]);
    }
    if (state.list[0].showMana() >= state.list[0].showManaCost('weakness')) {
      state = state.copyWith(buttonIgnore: [
        false,
        state.buttonIgnore[1],
        false,
        state.buttonIgnore[3]
      ]);
    }
    if (state.list[0].showMana() >= state.list[0].showManaCost('clearMe')) {
      state = state.copyWith(buttonIgnore: [
        false,
        state.buttonIgnore[1],
        state.buttonIgnore[2],
        false
      ]);
    } else {
      state = state.copyWith(buttonIgnore: [
        false,
        state.buttonIgnore[1],
        state.buttonIgnore[2],
        state.buttonIgnore[3]
      ]);
    }
  }
}

final myStateProvider = StateNotifierProvider<GameState, MyVars>((ref) {
  final repo = ref.watch(repoProvider);
  return GameState(repositoryGame: repo);
});
