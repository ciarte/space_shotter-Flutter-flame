import 'package:flutter/foundation.dart';
import 'package:space_shutter/models/player_ships_model.dart';

class PlayerData extends ChangeNotifier {
  SpaceShipsTypes spaceShipType;
  List<SpaceShipsTypes> ownSpaceShipsTypes;
  int highScore;
  int money;

  PlayerData(
      {required this.spaceShipType,
      required this.ownSpaceShipsTypes,
      required this.highScore,
      required this.money});

  PlayerData.fromMap(Map<String, dynamic> map)
      : spaceShipType = map['currentSpaceShipType'],
        ownSpaceShipsTypes = (map['ownSpaceShips'] as List)
            .map((e) => SpaceShipsTypes.values[e])
            .toList(),
        highScore = map['highScore'],
        money = map['money'];

  static Map<String, dynamic> defaultData = {
    'currentSpaceShipType': SpaceShipsTypes.bomber,
    'ownSpaceShips': [
      0,
    ],
    'highScore': 0,
    'money': 600
  };

  bool isOwned(SpaceShipsTypes spaceShip) {
    return ownSpaceShipsTypes.contains(spaceShip);
  }

  bool canBuy(SpaceShipsTypes spaceShip) {
    return money >= SpaceShips.getSpaceShipspByType(spaceShip).cost;
  }

  bool isEquiped(SpaceShipsTypes spaceShip) {
    return spaceShipType == spaceShip;
  }

  void buy(SpaceShipsTypes spaceShip) {
    if (canBuy(spaceShip) && !isOwned(spaceShip)) {
      money -= SpaceShips.getSpaceShipspByType(spaceShip).cost;
      ownSpaceShipsTypes.add(spaceShip);
      notifyListeners();
    }
  }

  void equiped(SpaceShipsTypes spaceShip) {
    spaceShipType = spaceShip;
    notifyListeners();
  }
}
