import 'dart:math';
import 'package:brave_steve/game/data_layer/models/save_model/save_model.dart';
import 'package:brave_steve/game/data_layer/repo/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data_layer/models/player_model/player_model.dart';

class MyVars {
  late bool _move1; //left side move
  late bool _move2; //right side move
  late List<bool>
      _ignore; //can press button or not - [atack, superatack,  weakness, clear]
  late List<PlayerModel> _list; // player (index 0)and enemies(indexes 1 to 4) and bosses (index 5 and 6) 
  late List<bool>
      _heroEffect; //index 0(left player) 1(right player) weakness,index 2(left player) 3(right player) clearance
  late bool _arrowGo;//skeleton arrow
  late int _index;//player index
  late int _skillPoints; //player skill points
  static const List<String> gameState = [
    "Koniec gry",
    "Wygrana",
    "Przegrana",
    "Gra Trwa"
  ];
  MyVars(
      {required bool move1,
      required bool move2,
      required List<bool> ignore,
      required List<PlayerModel> list,
      required List<bool> heroEffect,
      required int index,
      required bool arrowGo,
      required int skillPoints}) {
    _move1 = move1;
    _move2 = move2;
    _ignore = ignore;
    _list = list;
    _heroEffect = heroEffect;
    _index = index;
    _arrowGo = arrowGo;
    _skillPoints = skillPoints;
  }

  bool get move1 => _move1;
  bool get move2 => _move2;
  List<bool> get effect => _heroEffect;
  List<bool> get ignore => _ignore;
  List<PlayerModel> get list => _list;
  int get index => _index;
  bool get arrowGo => _arrowGo;
  int get skillPoints => _skillPoints;

  MyVars copyWith(
      {final bool? move1,
      final bool? move2,
      final List<bool>? ignore,
      final List<PlayerModel>? list,
      final List<bool>? heroEffect,
      final int? index,
      final bool? arrowGo,
      final int? skillPoints}) {
    return MyVars(
        move1: move1 ?? _move1,
        move2: move2 ?? _move2,
        ignore: ignore ?? _ignore,
        list: list ?? _list,
        heroEffect: heroEffect ?? _heroEffect,
        index: index ?? _index,
        arrowGo: arrowGo ?? _arrowGo,
        skillPoints: skillPoints ?? _skillPoints);
  }
}

class GameState extends StateNotifier<MyVars> {
  RepositoryGame repositoryGame;
  GameState(this.repositoryGame)
      : super(MyVars(
            move1: false,
            move2: false,
            ignore: [false, false, false, false],
            list: repositoryGame.playersStartStatsasPlayerModelList(),
            heroEffect: [false, false, false, false],
            index: 4,
            arrowGo: false,
            skillPoints: 5));

  Future<void> newGame() async {
    const List<bool> defaultSetList = [false, false, false, false];
    await repositoryGame.openGameDB();
    List<PlayerModel> l = await repositoryGame.listPlayerToListPlayerModel();
    state = state.copyWith(
      list: l,
      ignore: defaultSetList,
      heroEffect: defaultSetList,
    );
  }

  void loadGame(int index) {
    final players = repositoryGame.getPlayersfromDBasPlayerModelList(index);
    if (players.isNotEmpty) {
      state = state.copyWith(
          list: players,
          heroEffect: [
            players[0].isWeak(),
            players[players[0].getEnemyIndex()].isWeak(),
            false,
            false
          ],
          index: players[0].getEnemyIndex());
    }
  }

  Future<void> saveGame(String name) async {
    state._list[0].setEnemyIndex(state.index);
    await repositoryGame.addSaveGame(state._list, name);
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

  Future<String> battle({
    required bool superAtack,
    required bool cleary,
    required bool weakOnEnemy,
  }) async {
    if (state._list[0].isLive() && state._list[state.index].isLive()) {
      _firstPlayerCome(cleary);
      await Future.delayed(const Duration(milliseconds: 500));
      _hit(superAtack, cleary, weakOnEnemy);
      await Future.delayed(const Duration(milliseconds: 500));
    }
    if (state._list[state._index].isLive() && state._list[0].isLive()) {
      int option = _enemyCome();
      state = state.copyWith(arrowGo: true);
      await Future.delayed(const Duration(milliseconds: 500));
      state = state.copyWith(arrowGo: false);
      _enemyTurn(option);
    }
    if (!state._list[0].isLive() || !state._list[state._index].isLive()) {
      state = state.copyWith(ignore: [false, false, false, false]);
      if (state.list[0].getlvl() == 10) {
        return MyVars.gameState[0];
      } else {
        if (state._list[0].isLive()) {
          return MyVars.gameState[1];
        }
        return MyVars.gameState[2];
      }
    }
    return MyVars.gameState[3];
  }

  bool isLevelUp() {
    return state._list[0].showExp() == 100;
  }

  void chooseStats(int attack, int hp, int damageReduction) {
    state = state.copyWith(skillPoints: state._skillPoints - 1);
    state._list[0].growStatsMyHero(attack, hp, damageReduction);
  }

  void levelUp() {
    if (state._list[0].showExp() == 100) {
      state = state.copyWith(
          list: [
            state._list[0].levelUp(),
            state._list[1].levelUp(),
            state._list[2].levelUp(),
            state._list[3].levelUp(),
            state._list[4].levelUp(),
            state._list[5],
            state._list[6]
          ],
          heroEffect: [
            false,
            false,
            false,
            false
          ],
          skillPoints: 5,
          index: state._list[0].getlvl() == 5
              ? 5
              : state._list[0].getlvl() == 10
                  ? 6
                  : state.index);
    }
  }

  void winnerOrLoser(bool win) {
    const List<bool> effects = [false, false, false, false];
    win
        ? {
            if (state._list[0].showExp() != 100)
              {
                state._list[0].addExpirience(),
                state = state.copyWith(
                  heroEffect: effects,
                  list: [
                    state._list[0].setPlayerAgain(),
                    state._list[1].setPlayerAgain(),
                    state._list[2].setPlayerAgain(),
                    state._list[3].setPlayerAgain(),
                    state._list[4].setPlayerAgain(),
                    state._list[5],
                    state._list[6]
                  ],
                )
              },
            if (state._list[0].getlvl() != 4 &&
                    state._list[0].showExp() != 100 ||
                state._list[0].getlvl() != 9 && state._list[0].showExp() != 100)
              state = state.copyWith(index: Random().nextInt(4) + 1),
          }
        : {
            state = state.copyWith(
              list: repositoryGame.playersStartStatsasPlayerModelList(),
              heroEffect: effects,
            )
          };
  }

  void gameComplited() {
    state = state.copyWith(
        list: repositoryGame.playersStartStatsasPlayerModelList());
  }

//===================================================================================//
  // Private Methods
//===================================================================================//
  void _firstPlayerCome(bool cleary) {
    state = state.copyWith(
        heroEffect: [state.effect[0], state.effect[1], false, false],
        ignore: [true, true, true, true],
        move1: cleary ? false : true);
  }

  void _hit(bool superAtack, bool cleary, bool weakOnEnemy) {
    if (superAtack) {
      state._list[0].makeSuperAttack(state._list[state.index]);
    } else if (cleary) {
      state._list[0].clearMe();
      state = state.copyWith(heroEffect: [false, state.effect[1], true, false]);
    } else if (weakOnEnemy && !state._list[state.index].isWeak()) {
      state._list[0].weakness(state._list[state.index]);
      state = state.copyWith(heroEffect: [state.effect[0], true, false, false]);
    } else {
      state._list[0].makeAttack(state._list[state.index]);
    }
    state = state.copyWith(move1: false);
  }

  int _enemyCome() {
    state = state
        .copyWith(heroEffect: [state.effect[0], state.effect[1], false, false]);
    int option = Random().nextInt(3);
    option == 0 || option == 2
        ? state = state.copyWith(move2: true)
        : state._list[state.index].isWeak() &&
                state._list[state._index].showMana() >=
                    state._list[state._index].showManaCost('clearMe')
            ? state = state.copyWith(move2: false)
            : state = state.copyWith(move2: true);

    return option;
  }

  void _enemyTurn(int option) {
    switch (option) {
      case 0:
        if (state._list[state._index].showMana() >=
            state._list[state._index].showManaCost('SuperAttack')) {
          state._list[state._index].makeSuperAttack(state.list[0]);
        } else {
          state._list[state._index].makeAttack(state.list[0]);
        }
        break;
      case 1:
        {
          if (state._list[state.index].isWeak() &&
              state._list[state._index].showMana() >=
                  state._list[state._index].showManaCost('clearMe')) {
            state._list[state._index].clearMe();
            state = state
                .copyWith(heroEffect: [state.effect[0], false, false, true]);
          } else {
            state._list[state._index].makeAttack(state.list[0]);
          }
        }
        break;
      case 2:
        {
          if (!state._list[0].isWeak() &&
              state._list[state._index].showMana() >=
                  state._list[state._index].showManaCost('weakness')) {
            state._list[state._index].weakness(state._list[0]);
            state = state
                .copyWith(heroEffect: [true, state.effect[1], false, false]);
          } else {
            state._list[state._index].makeAttack(state.list[0]);
          }
        }
        break;
    }
    state = state.copyWith(move2: false);
    _setButtonsIgnore();
  }

  void _setButtonsIgnore() {
    if (state._list[0].showMana() >=
        state._list[0].showManaCost('SuperAttack')) {
      state = state
          .copyWith(ignore: [false, false, state.ignore[2], state.ignore[3]]);
    }
    if (state._list[0].showMana() >= state._list[0].showManaCost('weakness')) {
      state = state
          .copyWith(ignore: [false, state.ignore[1], false, state.ignore[3]]);
    }
    if (state._list[0].showMana() >= state._list[0].showManaCost('clearMe')) {
      state = state
          .copyWith(ignore: [false, state.ignore[1], state.ignore[2], false]);
    } else {
      state = state.copyWith(
          ignore: [false, state.ignore[1], state.ignore[2], state.ignore[3]]);
    }
  }
}

final myStateProvider = StateNotifierProvider<GameState, MyVars>((ref) {
  return GameState(RepositoryGame());
});
