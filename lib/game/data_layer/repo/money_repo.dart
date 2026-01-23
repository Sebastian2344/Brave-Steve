import 'package:brave_steve/game/data_layer/data_source/money_data/money_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoneyRepo {
  final MoneyData moneyData;
  MoneyRepo({required this.moneyData});

  Future<double> getMoneyFromDB() async {
    final money = await moneyData.getMoney();
    return double.tryParse(money) ?? 0.0;
  }

  Future<void> saveMoneyToDB(double money) async {
    await moneyData.saveMoney(money.toString());
  }
}

final moneyRepoProvider = Provider((ref) => MoneyRepo(moneyData: MoneyData()));