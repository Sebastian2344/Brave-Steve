import 'dart:math';
import 'package:brave_steve/game/data_layer/models/save_model/save_model.dart';
import 'package:brave_steve/game/data_layer/repo/repository.dart';
import 'package:brave_steve/game/state_menegment/eq_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data_layer/models/eq_model/eq_model.dart';
import '../data_layer/models/player_model/player_model.dart';
import '../data_layer/models/player_model/steve.dart';
enum Stan{
  koniecGry,wygrana,przegrana,graTrwa
}
class MyVars {
  late final bool _move1; //left side move
  late final bool _move2; //right side move
  late final List<bool>_buttonIgnore; //can press button or not - [atack, superatack,  weakness, clear]
  late final List<PlayerModel> _list; // player (index 0)and enemies(indexes 1 to 5) and bosses (index 6 and 7) 
  late final List<bool> _heroEffect; //index 0(left player) 1(right player) weakness,index 2(left player) 3(right player) clearance
  late final bool _arrowGo;//skeleton arrow
  late final int _enemyIndex;//enemy player index
  late final int _skillPoints; //player skill points
  
  MyVars(
      {required bool move1,
      required bool move2,
      required List<bool> buttonIgnore,
      required List<PlayerModel> list,
      required List<bool> heroEffect,
      required int index,
      required bool arrowGo,
      required int skillPoints}) : 
    _move1 = move1,
    _move2 = move2,
    _buttonIgnore = buttonIgnore,
    _list = list,
    _heroEffect = heroEffect,
    _enemyIndex = index,
    _arrowGo = arrowGo,
    _skillPoints = skillPoints;
  

  bool get move1 => _move1;
  bool get move2 => _move2;
  List<bool> get effect => _heroEffect;
  List<bool> get buttonIgnore => _buttonIgnore;
  List<PlayerModel> get list => _list;
  int get index => _enemyIndex;
  bool get arrowGo => _arrowGo;
  int get skillPoints => _skillPoints;

  MyVars copyWith(
      {final bool? move1,
      final bool? move2,
      final List<bool>? buttonIgnore,
      final List<PlayerModel>? list,
      final List<bool>? heroEffect,
      final int? index,
      final bool? arrowGo,
      final int? skillPoints}) {
    return MyVars(
        move1: move1 ?? _move1,
        move2: move2 ?? _move2,
        buttonIgnore: buttonIgnore ?? _buttonIgnore,
        list: list ?? _list,
        heroEffect: heroEffect ?? _heroEffect,
        index: index ?? _enemyIndex,
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
            buttonIgnore: [false, false, false, false],
            list: repositoryGame.playersStartStatsasPlayerModelList(),
            heroEffect: [false, false, false, false],
            index: 1,
            arrowGo: false,
            skillPoints: 5));

  Future<void> newGame() async {
    const List<bool> defaultSetList = [false, false, false, false];
    await repositoryGame.openGameDB();
    List<PlayerModel> l = await repositoryGame.listPlayerToListPlayerModel();
    state = state.copyWith(
      list: l,
      buttonIgnore: defaultSetList,
      heroEffect: defaultSetList,
      index: Random().nextInt(5) + 1
    );
  }

  void loadGame(int index) {
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
          index: (players[0] as Steve).getEnemyIndex());
    }
  }

  Future<void> saveGame(String name, WidgetRef ref) async {
    (state._list[0]as Steve).setEnemyIndex(state.index);
    final List<ItemPlaceModel> itemList = ref.read(providerEQ);
    await repositoryGame.addSaveGame(state._list, name,itemList);
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
    if (state._list[0].isLive() && state._list[state.index].isLive()) {
      _firstPlayerCome(cleary);
      await Future.delayed(const Duration(milliseconds: 500));
      _hit(superAtack, cleary, weakOnEnemy);
      await Future.delayed(const Duration(milliseconds: 500));
    }
    if (state._list[state._enemyIndex].isLive() && state._list[0].isLive()) {
      int option = _enemyCome();
      state = state.copyWith(arrowGo: true);
      await Future.delayed(const Duration(milliseconds: 500));
      state = state.copyWith(arrowGo: false);
      _enemyTurn(option);
      await Future.delayed(const Duration(milliseconds: 500));
    }
    if (!state._list[0].isLive() || !state._list[state._enemyIndex].isLive()) {
      state = state.copyWith(buttonIgnore: [false, false, false, false]);
      if (state._list[0].getlvl() == 10) {
        return Stan.koniecGry;
      } else {
        if (state._list[0].isLive()) {
          return Stan.wygrana;
        }
        return Stan.przegrana;
      }
    }
    return Stan.graTrwa;
  }

  bool isEq(){
    return state._list[state.index].showHp() == state._list[state.index].maxHpInfo() && state._list[state.index].getMaxArmour() == state._list[state.index].getArmour();
  }

  bool isLevelUp() {
    return state._list[0].showExp() == 100;
  }

  void chooseStats(int attack, int hp) {
    state = state.copyWith(list: [
            (state._list[0] as Steve).growStatsMyHero(attack,hp),
            state._list[1],
            state._list[2],
            state._list[3],
            state._list[4],
            state._list[5],
            state._list[6],
            state._list[7]
    ],skillPoints: state._skillPoints - 1);
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
            state._list[5].levelUp(),
            state._list[6],
            state._list[7]
          ],
          heroEffect: [
            false,
            false,
            false,
            false
          ],
          skillPoints: 5,
          index: state._list[0].getlvl() == 5
              ? 6
              : state._list[0].getlvl() == 10
                  ? 7
                  : state.index);   
    }
  }
  
  int lvl(){
    return state._list[0].getlvl();
  }

  void setStats((double,double,bool)record){
    if(record.$3){
      state._list[0].setArmour = record.$1;
      state._list[0].setMaxArmour = record.$1;
      state._list[0].setAttack = record.$2 + state._list[0].getMaxAttack();
      state._list[0].setMaxAttack = record.$2 + state._list[0].getMaxAttack();
    }else{
      state._list[0].setArmour = record.$1 + state._list[0].getArmour();
      state._list[0].setMaxArmour = record.$1 + state._list[0].getMaxArmour();
      state._list[0].setAttack = record.$2 + state._list[0].getMaxAttack();
      state._list[0].setMaxAttack = record.$2 + state._list[0].getMaxAttack();
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
                    state._list[5].setPlayerAgain(),
                    state._list[6],
                    state._list[7]
                  ],
                )
              },
            if (state._list[0].getlvl() != 4 &&
                    state._list[0].showExp() != 100 ||
                state._list[0].getlvl() != 9 && state._list[0].showExp() != 100)
              state = state.copyWith(index: Random().nextInt(5) + 1),
          }
        : {
            state = state.copyWith(
              list: repositoryGame.playersStartStatsasPlayerModelList(),
              heroEffect: effects,
              index: Random().nextInt(5) + 1,
              move2: false
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
        buttonIgnore: [true, true, true, true],
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
                state._list[state._enemyIndex].showMana() >=
                    state._list[state._enemyIndex].showManaCost('clearMe')
            ? state = state.copyWith(move2: false)
            : state = state.copyWith(move2: true);

    return option;
  }

  void _enemyTurn(int option) {
    if (option == 0) {
      if (state._list[state._enemyIndex].showMana() >=
          state._list[state._enemyIndex].showManaCost('SuperAttack')) {
        state._list[state._enemyIndex].makeSuperAttack(state.list[0]);
      } else {
        state._list[state._enemyIndex].makeAttack(state.list[0]);
      }
    } else if (option == 1) {
      {
        if (state._list[state.index].isWeak() &&
            state._list[state._enemyIndex].showMana() >=
                state._list[state._enemyIndex].showManaCost('clearMe')) {
          state._list[state._enemyIndex].clearMe();
          state = state
              .copyWith(heroEffect: [state.effect[0], false, false, true]);
        } else {
         int newOption = Random().nextInt(3);
         if(newOption != option){_enemyTurn(newOption);}else{state._list[state._enemyIndex].makeAttack(state.list[0]);}
        }
      }
    } else if (option == 2) {
      {
        if (!state._list[0].isWeak() &&
            state._list[state._enemyIndex].showMana() >=
                state._list[state._enemyIndex].showManaCost('weakness')) {
          state._list[state._enemyIndex].weakness(state._list[0]);
          state = state
              .copyWith(heroEffect: [true, state.effect[1], false, false]);
        } else {
          int newOption = Random().nextInt(3);
          if(newOption != option){_enemyTurn(newOption);}else{state._list[state._enemyIndex].makeAttack(state.list[0]);}
        }
      }
    }
    state = state.copyWith(move2: false);
    _setButtonsbuttonIgnore();
  }

  void _setButtonsbuttonIgnore() {
    if (state._list[0].showMana() >=
        state._list[0].showManaCost('SuperAttack')) {
      state = state
          .copyWith(buttonIgnore: [false, false, state.buttonIgnore[2], state.buttonIgnore[3]]);
    }
    if (state._list[0].showMana() >= state._list[0].showManaCost('weakness')) {
      state = state
          .copyWith(buttonIgnore: [false, state.buttonIgnore[1], false, state.buttonIgnore[3]]);
    }
    if (state._list[0].showMana() >= state._list[0].showManaCost('clearMe')) {
      state = state
          .copyWith(buttonIgnore: [false, state.buttonIgnore[1], state.buttonIgnore[2], false]);
    } else {
      state = state.copyWith(
          buttonIgnore: [false, state.buttonIgnore[1], state.buttonIgnore[2], state.buttonIgnore[3]]);
    }
  }
}

final myStateProvider = StateNotifierProvider<GameState, MyVars>((ref) {
  final repo = ref.watch(repoProvider);
  return GameState(repo);
});
