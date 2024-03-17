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
    SpaceShipsTypes.primary: SpaceShips(
      name: 'primary',
      speed: 250,
      life: 7,
      cost: 0,
      sprite: 'bomber.png',
      level: 1,
    ),
    SpaceShipsTypes.general: SpaceShips(
      name: 'general',
      speed: 290,
      life: 9,
      cost: 500,
      sprite: 'corvette.png',
      level: 3,
    ),
    SpaceShipsTypes.comander: SpaceShips(
      name: 'comander',
      speed: 350,
      life: 8,
      cost: 1000,
      sprite: 'fighter.png',
      level: 5,
    ),
    SpaceShipsTypes.fenix: SpaceShips(
      name: 'fenix',
      speed: 350,
      life: 10,
      cost: 2000,
      sprite: 'player.png',
      level: 6,
    ),
  };
}

enum SpaceShipsTypes {
  primary,
  general,
  comander,
  fenix,
}
