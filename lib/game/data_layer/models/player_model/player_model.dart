
abstract class PlayerModel{
  PlayerModel();
  void makeAttack(PlayerModel e);
  void makeSuperAttack(PlayerModel e);
  void weakness(PlayerModel e);
  void clearMe();
  void addExpirience();
  PlayerModel levelUp();
  PlayerModel setPlayerAgain();
  String getName();
  int showManaCost(String key);
  double showHp();
  double showMana();
  int showExp();
  int getlvl();
  double getArmour();
  double getMaxArmour();
  double getMaxAttack();
  double maxHpInfo();
  double showAttack();
  bool isLive(); 
  bool isWeak();
  set setWeak(bool weak);
  set setAttack(double attack);
  set setHp(double hp);
  set setMaxArmour(double maxArmour);
  set setArmour(double armour);
  set setMaxAttack(double maxAttack);
}