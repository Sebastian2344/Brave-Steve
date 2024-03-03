import '../../data_source/box.dart';

class PlayerModel {
  final String name;
  double _hp;
  double _maxHp;
  double _attack;
  double _mana;
  double _exp;
  int _lvl;
  bool _weak;
  int? _enemyIndex;
  int _damageReduction;

  PlayerModel(
    this.name,
    this._hp,
    this._maxHp,
    this._attack,
    this._mana,
    this._exp,
    this._lvl,
    this._weak,
    this._enemyIndex,
    this._damageReduction
  );
  
  void makeAttack(PlayerModel e) {
    if (_attack > e._hp) {
      e._hp = 0;
    } else {
      e._hp -= _attack - e._damageReduction;
    }
    if (_mana < 10) {
      _mana++;
    }
  }

  void setEnemyIndex(int i) {
    _enemyIndex = i;
  }

  int getEnemyIndex() {
    return _enemyIndex ?? 1;
  }

  void makeSuperAttack(PlayerModel e) {
    int cost = showManaCost('SuperAttack');
    if (_mana >= cost) {
      if (_attack * 2 > e._hp) {
        e._hp = 0;
      } else {
        e._hp -= _attack * 2 - e._damageReduction;
      }
      _mana -= cost;
    }
  }

  PlayerModel setPlayerAgain() {
    if(name == PlayerBox.playerNames[0]){
      _hp = _maxHp;
      if (_weak) {
        _attack = _attack + 2;
      }
    }else{
      _hp = 100 + 30 * (getlvl() - 1);
      _attack = 7 + 2 * (getlvl() - 1);
    }
    _mana = 10; 
    _weak = false;
    return this;
  }

  int showHp() {
    return _hp.toInt();
  }

  int showMana() {
    return _mana.toInt();
  }
  int damageReduction(){
    return _damageReduction;
  }

  static const Map<String, int> _manaCosts = {
    'SuperAttack': 4,
    'clearMe': 3,
    'weakness': 4
  };

  int showManaCost(String key) {
    return _manaCosts.entries
        .where((element) => element.key == key)
        .first
        .value;
  }

  bool isLive() {
    if (_hp == 0) {
      return false;
    } else {
      return true;
    }
  }

  PlayerModel levelUp() {
    if(name == PlayerBox.playerNames[0]){
      _mana = 10;
      _hp = _maxHp;
      _exp = 0;
      _lvl++; 
      return this;
      }else{
      _lvl++;
      _attack = _attack + 2;
      _mana = 10;
      _maxHp = 100 + 30 * (_lvl.toDouble() - 1);
      _hp = _maxHp;    
      _exp = 0;
      return this;
      }
  }

  PlayerModel growStatsMyHero(int attack,int hp,int damageReduction){
    if(name != PlayerBox.playerNames[0]){return this;}
    _attack += attack; 
    _maxHp += hp;
    _damageReduction += damageReduction;
    return this;
  }

  void weakness(PlayerModel e) {
    int cost = showManaCost('weakness');
    if (_mana >= cost) {
      e._weak = true;
      _mana = _mana - cost;
      e._attack = e._attack - 2;
    }
  }

  void clearMe() {
    int cost = showManaCost('clearMe');
    if (_mana >= cost) {
      _mana = _mana - cost;
      if (_weak) {
        _attack = _attack + 2;
      }
      _weak = false;
    }
  }

  bool isWeak() {
    if (_weak) {
      return true;
    }
    return false;
  }

  void addExpirience() {
    _exp += 50;
  }

  int showExp() {
    return _exp.toInt();
  }

  int getlvl() {
    return _lvl;
  }

  int maxHpInfo() {
    return _maxHp.toInt();
  }

  int showAttack() {
    return _attack.toInt();
  }
}
