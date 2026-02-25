import 'package:brave_steve/game/data_layer/data_source/counter_enemy/counter_enemy.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../eq/eq.dart';
import '../../models/save_model/save_model.dart';
import '../player/player.dart';

part 'save.g.dart';

@HiveType(typeId: 0)
class Save extends HiveObject {

  @HiveField(0)
  List<Player> list;
  @HiveField(1)
  String name;
  @HiveField(2)
  List<ItemPlace> itemPlace;
  @HiveField(3,defaultValue: CounterEnemy())
  CounterEnemy enemyCounter;
  @HiveField(4, defaultValue: 1)
  double expMultiply;
  Save({
    required this.list,
    required this.name,
    required this.itemPlace,
    required this.enemyCounter,
    required this.expMultiply
  });
  
  SaveModel toSaveModel(){
    return SaveModel(list: list.map((e) => e.toPlayerModel()).toList(),name: name);
  }
}
