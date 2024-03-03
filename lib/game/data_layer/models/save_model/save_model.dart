import 'package:brave_steve/game/data_layer/models/player_model/player_model.dart';

class SaveModel{
  final List<PlayerModel> list;
  final String name;
  SaveModel({required this.list,required this.name});
}