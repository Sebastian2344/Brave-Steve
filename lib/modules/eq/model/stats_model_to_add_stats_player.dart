import 'package:equatable/equatable.dart';

class StatsModelToAddStatsPlayer extends Equatable{
  final double attack;
  final double armour;
  const StatsModelToAddStatsPlayer({required this.attack, required this.armour});

  StatsModelToAddStatsPlayer copywith({double? attack, double? armour}) {
    return StatsModelToAddStatsPlayer(
        attack: attack ?? this.attack, armour: armour ?? this.armour);
  }

  @override
  List<Object?> get props => [attack, armour];
}