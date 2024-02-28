import 'package:flame/palette.dart';

class Palette {
  PaletteEntry get seed => const PaletteEntry(Color.fromARGB(255, 16, 57, 115));
  PaletteEntry get text =>
      const PaletteEntry(Color.fromARGB(255, 233, 237, 243));
  PaletteEntry get backgroundPlaySession =>
      const PaletteEntry(Color.fromARGB(255, 101, 75, 230));
  PaletteEntry get backgroundLevelSelection =>
      const PaletteEntry(Color.fromARGB(255, 5, 55, 79));
}
