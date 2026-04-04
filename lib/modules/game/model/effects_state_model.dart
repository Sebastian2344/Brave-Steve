import 'package:equatable/equatable.dart';

class EffectsStateModel extends Equatable {
  final bool isClearencePlayer;
  final bool isWeaknessPlayer;
  final bool isClearenceEnemy;
  final bool isWeaknessEnemy;

  const EffectsStateModel({
    required this.isClearencePlayer,
    required this.isWeaknessPlayer,
    required this.isClearenceEnemy,
    required this.isWeaknessEnemy,
  });

  EffectsStateModel copyWith({
    bool? isClearencePlayer,
    bool? isWeaknessPlayer,
    bool? isClearenceEnemy,
    bool? isWeaknessEnemy,
  }) {
    return EffectsStateModel(
      isClearencePlayer: isClearencePlayer ?? this.isClearencePlayer,
      isWeaknessPlayer: isWeaknessPlayer ?? this.isWeaknessPlayer,
      isClearenceEnemy: isClearenceEnemy ?? this.isClearenceEnemy,
      isWeaknessEnemy: isWeaknessEnemy ?? this.isWeaknessEnemy,
     );
  }
  @override
  List<Object?> get props => [
    isClearencePlayer,
    isWeaknessPlayer,
    isClearenceEnemy,
    isWeaknessEnemy
  ];
}