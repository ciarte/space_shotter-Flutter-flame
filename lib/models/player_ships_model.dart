class SpaceShips {
  final String name;
  final double speed;
  final int life;
  final int cost;
  final String sprite;
  final int level;

  const SpaceShips(
      {required this.name,
      required this.speed,
      required this.life,
      required this.cost,
      required this.sprite,
      required this.level});

  static SpaceShips getSpaceShipspByType(SpaceShipsTypes spaceShipsTypes) {
    return spaceShips[spaceShipsTypes] ?? spaceShips.entries.first.value;
  }

  static const Map<SpaceShipsTypes, SpaceShips> spaceShips = {
    SpaceShipsTypes.bomber: SpaceShips(
      name: 'bomber',
      speed: 250,
      life: 7,
      cost: 0,
      sprite: 'bomber.png',
      level: 1,
    ),
    SpaceShipsTypes.corvette: SpaceShips(
      name: 'corvette',
      speed: 300,
      life: 9,
      cost: 500,
      sprite: 'corvette.png',
      level: 3,
    ),
    SpaceShipsTypes.fighter: SpaceShips(
      name: 'fighter',
      speed: 350,
      life: 8,
      cost: 1000,
      sprite: 'fighter.png',
      level: 5,
    ),
  };
}

enum SpaceShipsTypes {
  bomber,
  corvette,
  fighter,
}
