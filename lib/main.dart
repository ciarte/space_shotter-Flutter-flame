import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:space_shutter/space_shooter_game.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Container with Game'),
      ),
      body: SizedBox(
        // width: 300, // Define el ancho deseado del juego
        // height: 400, // Define la altura deseada del juego
        child: GameWidget(game: SpaceShooterGame()),
      ),
    ),
  ));
}
