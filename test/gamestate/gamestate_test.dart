/*import 'package:brave_steve/game/data_source/box.dart';
import 'package:brave_steve/game/gamestate/game_state.dart';
import 'package:flutter_test/flutter_test.dart';


void main(){

  group('first player come', () { 
    test('first player come if cleary', () {
      //arrange
      final gamestate =  GameState();
      final myVars = MyVars(move1: false, move2: false, ignore: [false,false,false,false], list: PlayerBox.playersStartStats(), effect: [false,false,false,false], index: 1);
      gamestate.state = myVars;
      //act
      gamestate.firstPlayerCome(true);
      //assert
      expect(gamestate.state.move1,equals(false));
      expect(gamestate.state.ignore,equals([true,true,true,true]));
      expect(gamestate.state.effect,equals([myVars.effect[0],myVars.effect[1],false,false]));
    });
    test('first player come if not cleary', () {
      //arrange
      final gamestate =  GameState();
      final myVars = MyVars(move1: false, move2: false, ignore: [false,false,false,false], list: PlayerBox.playersStartStats(), effect: [false,false,false,false], index: 1);
      gamestate.state = myVars;
      //act
      gamestate.firstPlayerCome(false);
      //assert
      expect(gamestate.state.move1,equals(true));
      expect(gamestate.state.ignore,equals([true,true,true,true]));
      expect(gamestate.state.effect,equals([myVars.effect[0],myVars.effect[1],false,false]));
    });
  })
  
};*/