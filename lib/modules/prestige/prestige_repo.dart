import 'package:brave_steve/modules/prestige/prestige.dart';
import 'package:brave_steve/modules/prestige/prestige_data.dart';
import 'package:brave_steve/modules/prestige/prestige_model.dart';

class PrestigeRepo {
  const PrestigeRepo(this.prestigeData);
  final PrestigeData prestigeData;

  int calculatePoints(int level){
    return (level / 3).round();
  }

  Future<void> saveToDb(PrestigeModel model) async {
    await prestigeData.saveToDb(Prestige.toPrestige(model));
  }

  PrestigeModel fromDb(){
    return prestigeData.getData().toPrestigeModel();
  }
}