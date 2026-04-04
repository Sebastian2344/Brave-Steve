import 'package:brave_steve/core/di/providers.dart';
import 'package:brave_steve/modules/money/repo/money_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CashRegisterState extends Equatable {
  final double money;

  const CashRegisterState({required this.money});

  // Metoda do tworzenia nowej instancji stanu z zmienioną wartością
  CashRegisterState copyWith({double? money}) {
    return CashRegisterState(
      money: money ?? this.money,
    );
  }

  @override
  List<Object?> get props => [money];
}

// Definicja CashRegisterNotifier - zarządza logiką kasy
class CashRegisterNotifier extends AsyncNotifier<CashRegisterState> {
   MoneyRepo get repo => ref.read(moneyRepoProvider);

  @override
  build() async {
    ref.watch(moneyRepoProvider);
    state = const AsyncLoading();
    final m = await repo.getMoneyFromDB();
    return CashRegisterState(money: m);
  }
  
  // Metoda do dodawania kwoty do kasy
  Future<void> addmoney(double value) async {
    if (value < 0) {
      return;
    }
    state = AsyncData(state.value!.copyWith(money: state.value!.money + value));
    await _saveMoneyToRepo();
  }

  // Metoda do odejmowania kwoty z kasy
  Future<void> subtractmoney(double value) async {
    if (value < 0) {
      return;
    }
    if (state.value!.money - value < 0) {
      return;
    }
    state = AsyncData(state.value!.copyWith(money: state.value!.money - value));
    await _saveMoneyToRepo();
  }

  // Metoda do ustawiania konkretnej kwoty (opcjonalnie)
  Future<void> setmoney(double value) async{
    if (value < 0) {
      return;
    }
    state = AsyncData(state.value!.copyWith(money: value));
    await _saveMoneyToRepo();
  }
  Future<void> _saveMoneyToRepo() async {
    await repo.saveMoneyToDB(state.value!.money);
  }
}

// Provider dla CashRegisterNotifier
final moneyProvider =
    AsyncNotifierProvider<CashRegisterNotifier, CashRegisterState>(() {
  return CashRegisterNotifier();
});