import 'package:brave_steve/game/data_layer/models/effects_state_model/effects_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EffectsState extends Notifier<EffectsStateModel> {
  @override
  build() {
    return const EffectsStateModel(
        isClearencePlayer: false,
        isWeaknessPlayer: false,
        isClearenceEnemy: false,
        isWeaknessEnemy: false);
  }

  void setClearencePlayer(bool value) {
    state = state.copyWith(isClearencePlayer: value);
  }

  void setWeaknessPlayer(bool value) {
    state = state.copyWith(isWeaknessPlayer: value);
  }

  void setClearenceEnemy(bool value) {
    state = state.copyWith(isClearenceEnemy: value);
  }

  void setWeaknessEnemy(bool value) {
    state = state.copyWith(isWeaknessEnemy: value);
  }

  void setAllEffects(bool isWeaknessPlayer, bool isClearencePlayer,
      bool isClearenceEnemy, bool isWeaknessEnemy) {
    state = state.copyWith(
      isClearencePlayer: isClearencePlayer,
      isWeaknessPlayer: isWeaknessPlayer,
      isClearenceEnemy: isClearenceEnemy,
      isWeaknessEnemy: isWeaknessEnemy,
    );
  }

  void setWeaknessForAll(bool value) {
    state = state.copyWith(
      isWeaknessPlayer: value,
      isWeaknessEnemy: value,
    );
  }

  void setClearenceForAll(bool value) {
    state = state.copyWith(
      isClearencePlayer: value,
      isClearenceEnemy: value,
    );
  }

  void clearEffects() {
    state = state.copyWith(
      isClearencePlayer: false,
      isWeaknessPlayer: false,
      isClearenceEnemy: false,
      isWeaknessEnemy: false,
    );
  }
}

final effectsStateProvider =
    NotifierProvider<EffectsState, EffectsStateModel>(() => EffectsState());
