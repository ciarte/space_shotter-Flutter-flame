import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:space_shutter/level_selection/world_selection_screen.dart';
import 'package:space_shutter/level_selection/levels.dart';

import 'package:space_shutter/style/style.dart';

class ShipSelection extends StatelessWidget {
  const ShipSelection({super.key});

  @override
  Widget build(BuildContext context) {
    //size total de la pantalla
    final size = MediaQuery.of(context).size;
    // final palette = context.watch<Palette>();

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
          Padding(
            padding: EdgeInsets.only(top: size.height / 3),
            child: Swiper(
              scale: 0.5,
              viewportFraction: 0.65,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: gameLevels.length,
              itemBuilder: (conext, index) {
                return WorldSelectionScreen(world: gameLevels[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
