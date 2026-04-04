import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class MoneyData {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<String> getMoney() async {
    return await storage.read(key: 'money') ?? '0';
  }

  Future<void> saveMoney(String money) async {
    await storage.write(key: 'money', value: money);
  }
}