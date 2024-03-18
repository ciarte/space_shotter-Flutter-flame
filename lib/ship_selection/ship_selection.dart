import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
// import 'package:space_shutter/level_selection/levels.dart';
import 'package:space_shutter/models/player_ships_model.dart';
import 'package:space_shutter/player_progress/player_data.dart';
// import 'package:space_shutter/player_progress/player_progress.dart';
import 'package:space_shutter/style/style.dart';
import 'package:space_shutter/style/wobbly_button.dart';

class ShhipSeceltion extends StatelessWidget {
  const ShhipSeceltion({
    super.key,
    required this.ships,
  });
  final int ships;
  // final SpaceShipsTypes spaceShip = spaceShip.s ;
  static const _gap = SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final spaceShip = SpaceShips.spaceShips.entries.elementAt(ships).value;
    final playerProgress = context.watch<PlayerData>();
    // final blocked = playerProgress.worlds.length >= world.number - 1;
    // final blocked = ship.number > 1;
    final type = SpaceShips.spaceShips.entries.elementAt(ships).key;
    final isEquiped = playerProgress.isEquiped(type);
    final isOwned = playerProgress.isOwned(type);
    final canBuy = playerProgress.canBuy(type);
    return Column(
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(-0.5 * pi), // Girar horizontalmente
          child: Image.asset(
            'assets/images/${spaceShip.name}_idle.png',
            scale: 0.5,
          ),
        ),
        WobblyButton(
          onPressed: isEquiped
              ? null
              : () {
                  if (isOwned) {
                    playerProgress.equiped(type);
                  } else {
                    if (canBuy) {
                      playerProgress.buy(type);
                    } else {
                      showDialog(
                          context: context,
                          builder: (contex) {
                            return AlertDialog(
                              title: const Text('Insufficient funds'),
                              content: Text(
                                'Need ${spaceShip.cost - playerProgress.money} more coins',
                                textAlign: TextAlign.center,
                              ),
                            );
                          });
                    }
                  }
                },
          child: Text(isEquiped
              ? 'Equiped'
              : isOwned
                  ? 'Select'
                  : 'Buy'),
        ),
        _gap,
        Text(
          spaceShip.name,
          style: TextStyle(
            fontSize: 20,
            color: palette.text.color,
          ),
        ),
        _gap,
        Text(
          'Value: ${spaceShip.cost}',
          style: TextStyle(
            fontSize: 14,
            color: palette.text.color,
          ),
        ),
        _gap,
        Text(
          'Speed: ${spaceShip.speed.toInt()} Km/h',
          style: TextStyle(
            fontSize: 14,
            color: palette.text.color,
          ),
        ),
        _gap,
        Text(
          'Level: ${spaceShip.level}',
          style: TextStyle(
            fontSize: 14,
            color: palette.text.color,
          ),
        ),
        // _gap,
        // Text(
        //   'naves: ${(playerProgress.ownSpaceShipsTypes).toList()}',
        //   style: TextStyle(
        //     fontSize: 14,
        //     color: palette.text.color,
        //   ),
        // ),
        // _gap,
        // Text(
        //   'selecionado: ${(playerProgress.spaceShipType)}',
        //   style: TextStyle(
        //     fontSize: 14,
        //     color: palette.text.color,
        //   ),
        // ),
      ],
    );
  }
}
