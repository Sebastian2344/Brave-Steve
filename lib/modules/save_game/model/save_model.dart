import 'package:brave_steve/modules/game/model/player_model.dart';

class SaveModel{
  final List<PlayerModel> list;
  final String name;
  const SaveModel({required this.list,required this.name});
}