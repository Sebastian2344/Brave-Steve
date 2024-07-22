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
  Save({
    required this.list,
    required this.name,
    required this.itemPlace,
  });
  
  SaveModel toSaveModel(){
    return SaveModel(list: list.map((e) => e.toPlayerModel()).toList(),name: name);
  }
}
