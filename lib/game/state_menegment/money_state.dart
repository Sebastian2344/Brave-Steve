import 'package:brave_steve/game/data_layer/repo/money_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CashRegisterState {
  final double money;

  const CashRegisterState({required this.money});

  // Metoda do tworzenia nowej instancji stanu z zmienioną wartością
  CashRegisterState copyWith({double? money}) {
    return CashRegisterState(
      money: money ?? this.money,
    );
  }
}

// Definicja CashRegisterNotifier - zarządza logiką kasy
class CashRegisterNotifier extends AsyncNotifier<CashRegisterState> {
   MoneyRepo get repo => ref.read(moneyRepoProvider);

  @override
  build() async {
    ref.watch(moneyRepoProvider);
    state = const AsyncData(CashRegisterState(money: 0.0));
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