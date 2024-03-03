// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';

import '../player/player.dart';
import '../save_model/save_model.dart';

part 'save.g.dart';

@HiveType(typeId: 0)
class Save extends HiveObject {

  @HiveField(0)
  List<Player> list;
  @HiveField(1)
  String name;
  Save({
    required this.list,required this.name
  });
  
  SaveModel toSaveModel(){
    return SaveModel(list: list.map((e) => e.toPlayerModel()).toList(),name: name);
  }
}
