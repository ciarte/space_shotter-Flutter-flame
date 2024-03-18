import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:space_shutter/models/player_ships_model.dart';
import 'package:space_shutter/player_progress/player_data.dart';
import 'package:space_shutter/ship_selection/ship_selection.dart';

import 'package:space_shutter/style/style.dart';

class ShipSelectionScreen extends StatelessWidget {
  const ShipSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //size total de la pantalla
    final size = MediaQuery.of(context).size;
    // final palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerData>();
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/fondo5.jpg',
            filterQuality: FilterQuality.low,
            fit: BoxFit.fitHeight,
            height: size.height,
          ),
          Positioned(
            right: 20,
            top: 20,
            child: WobblyButton(
              onPressed: () {
                GoRouter.of(context).go('/');
              },
              child: const Text('Back'),
            ),
          ),
          Positioned(
            left: 20,
            top: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Money: ${playerProgress.money}'),
                Text('Ship: ${playerProgress.spaceShipType.name}'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height / 5),
            child: Swiper(
              scale: 0.5,
              viewportFraction: 0.65,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: SpaceShips.spaceShips.length,
              itemBuilder: (conext, index) {
                return ShhipSeceltion(ships: index);
              },
            ),
          ),
          Positioned(
            bottom: 100,
            right: size.height / 8,
            child: WobblyButton(
              onPressed: () {
                GoRouter.of(context).go('/world_screen');
              },
              child: const Text('Select wolrd'),
            ),
          ),
        ],
      ),
    );
  }
}
