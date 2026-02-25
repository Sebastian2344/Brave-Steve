import 'player_model.dart';

class Enemy extends PlayerModel {
  bool _weak;
  final String _name;
  double _hp;
  double _maxHp;
  double _attack;
  double _maxAttack;
  double _mana;
  double _exp;
  int _lvl;
  double _armour;
  double _maxArmour;

  Enemy(
    this._name,
    this._hp,
    this._maxHp,
    this._attack,
    this._maxAttack,
    this._mana,
    this._exp,
    this._armour,this._maxArmour,
    this._lvl,
    this._weak) : super();

  @override
  void makeAttack(PlayerModel e) {
    if (_attack > e.showHp()) {
      e.setHp = 0;
    } else {
      if(e.getArmour() > 0 && _attack < e.getArmour()){
        e.setArmour = e.getArmour() - _attack;
      }else if(e.getArmour() > 0 && _attack > e.getArmour()){
        double myHpAtack = _attack;
        double myArmourAtack = _attack;
        myHpAtack = _attack - e.getArmour();
        myArmourAtack = _attack - myHpAtack;
        e.setArmour = e.getArmour() - myArmourAtack;
        e.setHp = e.showHp() - myHpAtack;
      }else{
        e.setHp = e.showHp() - _attack;
      }
    }
    if (_mana < 10) {
      _mana++;
    }
  }

  @override
  void makeSuperAttack(PlayerModel e) {
    int cost = showManaCost('SuperAttack');
    if (_mana >= cost) {
      if (_attack * 2 > e.showHp()) {
        e.setHp = 0;
      } else {
        if(e.getArmour() > 0 && _attack * 2 < e.getArmour()){
        e.setArmour = e.getArmour() - _attack * 2;
      }else if(e.getArmour() > 0 && _attack * 2 > e.getArmour()){
        double myHpAtack = _attack * 2;
        double myArmourAtack = _attack * 2;
        myHpAtack = _attack * 2 - e.getArmour();
        myArmourAtack = _attack * 2 - myHpAtack;
        e.setArmour = e.getArmour() - myArmourAtack;
        e.setHp = e.showHp() - myHpAtack;
      }else{
        e.setHp = e.showHp() - _attack * 2;
      }
      }
      _mana -= cost;
    }
  }

  @override
  PlayerModel setPlayerAgain() {
    _weak = false;
    _hp = _maxHp;
    _attack = _maxAttack;
    _mana = 10;
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
    return _hp <= 0 ? false : true;
  }

  @override
  PlayerModel levelUp() {
    _lvl++;
    _attack = _attack + 4;
    _maxAttack = _attack;
    _mana = 10;
    _maxHp = _maxHp + 40;
    _hp = _maxHp;
    _exp = 0;
    _armour = _maxArmour = 4 * (_lvl.toDouble() - 1);
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
  void addExpirience(double multiply,double exp) => _exp += exp * multiply;

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
  
  @override
  double getMaxArmour() {
    return _maxArmour;
  }
}
