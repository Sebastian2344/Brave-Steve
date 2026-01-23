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
class CashRegisterNotifier extends StateNotifier<CashRegisterState> {
  CashRegisterNotifier({required this.repo}) : super(const CashRegisterState(money: 0.0)) {
    _loadMoneyFromRepo();
  }
  final MoneyRepo repo;
  // Metoda do dodawania kwoty do kasy
  Future<void> addmoney(double value) async {
    if (value < 0) {
      return;
    }
    state = state.copyWith(money: state.money + value);
    await _saveMoneyToRepo();
  }

  // Metoda do odejmowania kwoty z kasy
  Future<void> subtractmoney(double value) async {
    if (value < 0) {
      return;
    }
    if (state.money - value < 0) {
      return;
    }
    state = state.copyWith(money: state.money - value);
    await _saveMoneyToRepo();
  }

  // Metoda do ustawiania konkretnej kwoty (opcjonalnie)
  Future<void> setmoney(double value) async{
    if (value < 0) {
      return;
    }
    state = state.copyWith(money: value);
    await _saveMoneyToRepo();
  }
  // Metoda do ładowania pieniędzy z repozytorium
  Future<void> _loadMoneyFromRepo() async {
    final m = await repo.getMoneyFromDB();
    state = state.copyWith(money: m);
  }

  Future<void> _saveMoneyToRepo() async {
    await repo.saveMoneyToDB(state.money);
  }
}

// Provider dla CashRegisterNotifier
final moneyProvider =
    StateNotifierProvider<CashRegisterNotifier, CashRegisterState>((ref) {
      final repo = ref.watch(moneyRepoProvider);
  return CashRegisterNotifier(repo : repo);
});