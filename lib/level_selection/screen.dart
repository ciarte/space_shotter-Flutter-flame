import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:space_shutter/level_selection/world_selection_creen.dart';
import 'package:space_shutter/level_selection/levels.dart';

class Screen extends StatelessWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    //size total de la pantalla
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Image.asset(
          'assets/images/fondo5.jpg',
          // filterQuality: FilterQuality.low,
          fit: BoxFit.fitHeight,
          height: size.height,
        ),
        Padding(
          padding: EdgeInsets.only(top: size.height / 3),
          child: Swiper(
            scale: 0.2,
            viewportFraction: 0.5,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: gameLevels.length,
            itemBuilder: (conext, index) {
              return Column(
                children: [
                  WorldSelectionScreen(world: gameLevels[index]),
                  Text(gameLevels[index].number.toString())
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
