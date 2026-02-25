// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'player_model.dart';

class Steve extends PlayerModel {
  bool _weak;
  final String _name;
  double _hp;
  double _maxHp;
  double _attack;
  double _maxAttack;
  double _mana;
  double _exp;
  int _lvl;
  int? _enemyIndex;
  double _armour;
  double _maxArmour;

  Steve(
      this._name,
      this._hp,
      this._maxHp,
      this._attack,
      this._maxAttack,
      this._mana,
      this._exp,
      this._armour,
      this._maxArmour,
      this._lvl,
      this._weak,
      [this._enemyIndex])
      : super();

  @override
  void makeAttack(PlayerModel e) {
    if (_attack > e.showHp()) {
      e.setHp = 0;
    } else {
      if (e.getArmour() > 0 && _attack < e.getArmour()) {
        e.setArmour = e.getArmour() - _attack;
      } else if (e.getArmour() > 0 && _attack > e.getArmour()) {
        double myHpAtack = _attack;
        double myArmourAtack = _attack;
        myHpAtack = _attack - e.getArmour();
        myArmourAtack = _attack - myHpAtack;
        e.setArmour = e.getArmour() - myArmourAtack;
        e.setHp = e.showHp() - myHpAtack;
      } else {
        e.setHp = e.showHp() - _attack;
      }
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

  @override
  void makeSuperAttack(PlayerModel e) {
    int cost = showManaCost('SuperAttack');
    if (_mana >= cost) {
      if (_attack * 2 > e.showHp()) {
        e.setHp = 0;
      } else {
        if (e.getArmour() > 0 && _attack * 2 < e.getArmour()) {
          e.setArmour = e.getArmour() - _attack * 2;
        } else if (e.getArmour() > 0 && _attack * 2 > e.getArmour()) {
          double myHpAtack = _attack * 2;
          double myArmourAtack = _attack * 2;
          myHpAtack = _attack * 2 - e.getArmour();
          myArmourAtack = _attack * 2 - myHpAtack;
          e.setArmour = e.getArmour() - myArmourAtack;
          e.setHp = e.showHp() - myHpAtack;
        } else {
          e.setHp = e.showHp() - _attack * 2;
        }
      }
      _mana -= cost;
    }
  }

  @override
  PlayerModel setPlayerAgain() {
    _hp = _maxHp;
    if (_weak) {
      _attack = _maxAttack;
    }
    _mana = 10;
    _weak = false;
    _armour = _maxArmour;
    return this;
  }

  static const Map<String, int> _manaCosts = {
    'SuperAttack': 4,
    'clearMe': 3,
    'weakness': 4
  };

  @override
  int showManaCost(String key) {
    return _manaCosts.entries
        .where((element) => element.key == key)
        .first
        .value;
  }

  @override
  bool isLive() {
    if (_hp <= 0) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Steve levelUp() {
    _lvl++;
    _attack = _attack + 2;
    _maxAttack = _attack;
    _mana = 10;
    _maxHp = _maxHp + 20;
    _hp = _maxHp;
    _exp = 0;
    return this;
  }

  @override
  void weakness(PlayerModel e) {
    int cost = showManaCost('weakness');
    if (_mana >= cost) {
      e.setWeak = true;
      _mana = _mana - cost;
      e.setAttack = e.showAttack() - e.showAttack() * 0.3;
    }
  }

  @override
  void clearMe() {
    int cost = showManaCost('clearMe');
    if (_mana >= cost) {
      _mana = _mana - cost;
      if (_weak) {
        _attack = _maxAttack;
      }
      _weak = false;
    }
  }

  @override
  double showHp() => double.parse(_hp.toStringAsFixed(2));

  @override
  double showMana() => double.parse(_mana.toStringAsFixed(2));

  @override
  bool isWeak() => _weak;

  @override
  void addExpirience(double multiply,double exp) {
    if(_exp + exp * multiply >= 100){
      _exp = 100;
    } else {
      _exp += exp * multiply;
    }
  } 

  @override
  int showExp() => _exp.toInt();

  @override
  int getlvl() => _lvl;

  @override
  double maxHpInfo() => _maxHp;

  @override
  double showAttack() => double.parse(_attack.toStringAsFixed(2));

  @override
  String getName() => _name;

  @override
  double getMaxAttack() => _maxAttack;

  @override
  set setAttack(double attack) {
    _attack = attack;
  }

  @override
  set setWeak(bool weak) {
    _weak = weak;
  }

  @override
  set setHp(double hp) {
    _hp = hp;
  }

  @override
  double getArmour() {
    return _armour;
  }
  
  @override
  double getMaxArmour() {
    return _maxArmour;
  }

  @override
  set setMaxArmour(double maxArmour) {
    _maxArmour = maxArmour;
  }
  
  @override
  set setMaxAttack(double maxAttack) {
    _maxAttack = maxAttack;
  }
  
  @override
  set setArmour(double armour) {
    _armour = armour;
  }
}