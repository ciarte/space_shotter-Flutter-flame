import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

import 'package:space_shutter/style/style.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  static const _gap = SizedBox(
    height: 20,
  );
  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: palette.backgroundPlaySession.color,
        body: Stack(children: [
          Image.asset('assets/images/banner1.png',
              filterQuality: FilterQuality.none,
              fit: BoxFit.fitHeight,
              // width: 150,
              height: size.height),
          _gap,
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.3),
            child: Text(
              'Galaxy Defender',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Press Start 2P',
                fontSize: 36,
                color: palette.text.color,
              ),
            ),
          ),
          _gap,
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.6),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  WobblyButton(
                      child: const Text('Play'),
                      onPressed: () {
                        print('PLAY');
                        context.go('/play');
                      }),
                  _gap,
                  WobblyButton(
                    child: const Text('Settings'),
                    onPressed: () => print('Settings'),
                  ),
                ],
              ),
              _gap,
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      size: 40,
                      Icons.volume_up,
                      color: palette.text.color,
                    )),
              ),
              _gap,
              const Text('Built with Flame'),
              _gap,
              const Text('by Ciarte studios'),
            ]),
          )
        ]));
  }
}
