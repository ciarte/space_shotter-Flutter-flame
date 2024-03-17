import 'package:flame/palette.dart';

class Palette {
  PaletteEntry get seed => const PaletteEntry(Color.fromARGB(255, 92, 1, 219));
  PaletteEntry get text2 =>
      const PaletteEntry(Color.fromARGB(255, 250, 251, 251));
  PaletteEntry get text =>
      const PaletteEntry(Color.fromARGB(255, 73, 121, 210));
  PaletteEntry get backgroundPlaySession =>
      const PaletteEntry(Color.fromARGB(255, 101, 75, 230));
  PaletteEntry get backgroundLevelSelection =>
      const PaletteEntry(Color.fromARGB(255, 11, 25, 32));
  PaletteEntry get backgroundDialog =>
      PaletteEntry(Color.fromRGBO(250, 251, 251, 0.3));
  PaletteEntry get backgroundSelectLevels =>
      const PaletteEntry(Color.fromARGB(255, 43, 170, 164));
}
