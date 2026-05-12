import 'package:equatable/equatable.dart';

class PrestigeModel extends Equatable{
  final bool isGivePoints;
  final int points;
  final double attack;
  final double health;
  final double lucky;
  final int calculatedPoints;

  const PrestigeModel({required this.points,required this.attack,required this.health,required this.isGivePoints, required this.lucky, required this.calculatedPoints});

  PrestigeModel copywith({int? points, double? attack,double? health, bool? isGivePoints, double? lucky, int? calculatedPoints}) {
    return PrestigeModel(
        points: points ?? this.points,
        attack: attack ?? this.attack,
        health: health ?? this.health,
        isGivePoints: isGivePoints ?? this.isGivePoints,
        lucky: lucky ?? this.lucky,
        calculatedPoints:  calculatedPoints ?? this.calculatedPoints);
  }

  @override
  List<Object?> get props => [points,attack,health,isGivePoints,calculatedPoints]; 
}