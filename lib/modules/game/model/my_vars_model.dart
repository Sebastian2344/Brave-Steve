import 'package:brave_steve/modules/game/model/player_model.dart';
import 'package:equatable/equatable.dart';

class MyVars extends Equatable {
  final bool move1; //left side move
  final bool move2; //right side move
  final List<PlayerModel>
      list; // player (index 0)and enemies(indexes 1 to 5) and bosses (index 6 and 7)
  final int enemyIndex; //enemy player index
  final Enum gameState;
  final double expMultiply;

  const MyVars(
      {required this.move1,
      required this.move2,
      required this.list,
      required this.enemyIndex,
      required this.gameState,
      required this.expMultiply});

  MyVars copyWith(
      {final bool? move1,
      final bool? move2,
      final List<PlayerModel>? list,
      final int? enemyIndex,
      final Enum? gameState,
      final double? expMultiply}) {
    return MyVars(
        move1: move1 ?? this.move1,
        move2: move2 ?? this.move2,
        list: list ?? this.list,
        enemyIndex: enemyIndex ?? this.enemyIndex,
        gameState: gameState ?? this.gameState,
        expMultiply: expMultiply ?? this.expMultiply);
  }

  @override
  List<Object?> get props => [
        move1,
        move2,
        list,
        enemyIndex,
        gameState,
        expMultiply
      ];
}