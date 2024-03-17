import 'package:flutter/foundation.dart';
import 'package:space_shutter/models/player_ships_model.dart';

class PlayerData extends ChangeNotifier {
  final SpaceShipsTypes spaceShipType;
  final List<SpaceShipsTypes> ownSpaceShipsTypes;
  final int highScore;
  final int money;

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
    'currentSpaceShipType': SpaceShipsTypes.primary,
    'ownSpaceShips': [],
    'highScore': 0,
    'money': 0
  };
}
