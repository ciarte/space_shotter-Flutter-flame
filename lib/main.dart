import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import 'package:nes_ui/nes_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:space_shutter/app_life_cicle/app_lifecycle.dart';

import 'package:space_shutter/router.dart';

import 'package:space_shutter/style/style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  runApp(const MyGame());
}

class MyGame extends StatelessWidget {
  const MyGame({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
        child: MultiProvider(
            providers: [
          Provider(create: (context) => Palette()),
        ],
            child: Builder(builder: (context) {
              final palette = context.watch<Palette>();

              return MaterialApp.router(
                theme: flutterNesTheme().copyWith(
                  textTheme: GoogleFonts.pressStart2pTextTheme().apply(
                    bodyColor: palette.text.color,
                    displayColor: palette.text.color,
                  ),
                ),
                debugShowCheckedModeBanner: false,
                // routerConfig: goRouter,
                routeInformationProvider: goRouter.routeInformationProvider,
                routeInformationParser: goRouter.routeInformationParser,
                routerDelegate: goRouter.routerDelegate,
              );
            })));
  }
}
