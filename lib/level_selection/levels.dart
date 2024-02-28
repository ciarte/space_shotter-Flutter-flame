const gameLevels = <GameLevel>[
  (
    number: 1,
    winScore: 13,
    canSpawnTall: false,
  ),
  (
    number: 2,
    winScore: 25,
    canSpawnTall: true,
  ),
  (
    number: 3,
    winScore: 55,
    canSpawnTall: true,
  ),
  (
    number: 4,
    winScore: 35,
    canSpawnTall: true,
  ),
  (
    number: 5,
    winScore: 20,
    canSpawnTall: true,
  ),
  (
    number: 6,
    winScore: 25,
    canSpawnTall: true,
  ),
  (
    number: 7,
    winScore: 10,
    canSpawnTall: true,
  ),
];

typedef GameLevel = ({
  int number,
  int winScore,
  bool canSpawnTall,
});

// class GameLevel {
//   final int number;
//   final int winScore;
//   final bool canSpawnTall;

//   GameLevel({
//     required this.number,
//     required this.winScore,
//     required this.canSpawnTall,
//   });
// }

// final List<GameLevel> gameLevels = [
//   GameLevel(
//     number: 1,
//     winScore: 3,
//     canSpawnTall: false,
//   ),
//   GameLevel(
//     number: 2,
//     winScore: 5,
//     canSpawnTall: true,
//   ),
// ];