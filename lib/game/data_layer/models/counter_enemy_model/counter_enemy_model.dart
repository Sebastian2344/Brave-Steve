import 'package:equatable/equatable.dart';

class CounterEnemyModel extends Equatable {
  final int enemyCounter;
  final int boss;
  const CounterEnemyModel(this.enemyCounter, this.boss);

  CounterEnemyModel copywith({int? enemyCounter, int? boss}) {
    return CounterEnemyModel(
        enemyCounter ?? this.enemyCounter, boss ?? this.boss);
  }

  @override
  List<Object?> get props => [enemyCounter, boss];
}
