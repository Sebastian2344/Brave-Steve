import 'package:brave_steve/modules/counter_enemy_and_bioms/db_model/counter_enemy.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../eq/db_model/eq.dart';
import '../model/save_model.dart';
import '../../game/db_model/player.dart';

part 'save.g.dart';

@HiveType(typeId: 0)
class Save {

  @HiveField(0)
  final List<Player> list;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final List<ItemPlace> itemPlace;
  @HiveField(3,defaultValue: CounterEnemy())
  final CounterEnemy enemyCounter;
  @HiveField(4, defaultValue: 1)
  final double expMultiply;
  const Save({
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
