import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActionButtonIgnoreModel extends Equatable{
  final bool atack;
  final bool superAtack;
  final bool cleary;
  final bool weakOnEnemy;

  const ActionButtonIgnoreModel(this.atack, this.superAtack, this.cleary, this.weakOnEnemy);

  ActionButtonIgnoreModel copywith({bool? atack, bool? superAtack, bool? cleary, bool? weakOnEnemy}) {
    return ActionButtonIgnoreModel(
      atack ?? this.atack,
      superAtack ?? this.superAtack,
      cleary ?? this.cleary,
      weakOnEnemy ?? this.weakOnEnemy,
    );
  }
  @override
  List<Object?> get props => [atack, superAtack, cleary, weakOnEnemy];
}


class ActionButtonIgnoreNotifier extends Notifier<ActionButtonIgnoreModel> {
  
  @override
  build(){
    return ActionButtonIgnoreModel(false, false, false, false);
  }

  void reset() {
    state = const ActionButtonIgnoreModel(false, false, false, false);
  }

  void setAllIgnore(){
    state = const ActionButtonIgnoreModel(true, true, true, true);
  }
  
  void changeAtack(bool value) {
    state = state.copywith(atack: value);
  }

  void changeSuperAtack(bool value) {
    state = state.copywith(superAtack: value);
  }

  void changeCleary(bool value) {
    state = state.copywith(cleary: value);
  }

  void changeWeakOnEnemy(bool value) {
    state = state.copywith(weakOnEnemy: value);
  }
}

final actionButtonIgnoreProvider =
    NotifierProvider<ActionButtonIgnoreNotifier, ActionButtonIgnoreModel>(() {
  return ActionButtonIgnoreNotifier();
});