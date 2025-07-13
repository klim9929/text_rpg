abstract class Player {
  String get className;
  int get hp;
  int get mp;
  int get gold;
  String get currentLocation;

  void attack(String enemyName);
  void defend();
  void specialAction();
  bool isAlive();
  void takeDamage(int damage);
}

class Warrior extends Player {
  @override
  String get className => 'Воин';
  @override
  int hp = 120;
  @override
  int mp = 20;
  @override
  int gold = 50;
  @override
  String currentLocation = 'Таверна';

  @override
  void attack(String enemyName) {
    hp -= 5;
    print("Атаковал $enemyName! Урон: 20 HP");
  }

  @override
  void defend() {
    hp += 10;
    print("Повысил защиту на 10 HP");
  }

  @override
  void specialAction() {
    if (mp >= 10) {
      mp -= 10;
      print("Специальное действие: Бешеный натиск! +20 урона");
    }
  }

  @override
  bool isAlive() => hp > 0;

  @override
  void takeDamage(int damage) {
    hp -= damage;
    if (hp < 0) hp = 0;
  }
}
