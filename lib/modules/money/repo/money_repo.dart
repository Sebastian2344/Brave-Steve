import 'package:brave_steve/modules/money/money_data/money_data.dart';

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