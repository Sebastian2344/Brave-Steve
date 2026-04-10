import 'package:equatable/equatable.dart';

class PrestigeModel extends Equatable{
  final bool isGivePoints;
  final int points;
  final double attack;
  final double health;

  const PrestigeModel({required this.points,required this.attack,required this.health,required this.isGivePoints});

  PrestigeModel copywith({int? points, double? attack,double? health, bool? isGivePoints}) {
    return PrestigeModel(
        points: points ?? this.points,
        attack: attack ?? this.attack,
        health: health ?? this.health,
        isGivePoints: isGivePoints ?? this.isGivePoints);
  }

  @override
  List<Object?> get props => [points,attack,health,isGivePoints]; 
}