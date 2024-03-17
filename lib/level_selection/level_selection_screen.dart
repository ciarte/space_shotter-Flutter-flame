import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:space_shutter/level_selection/levels.dart';
import 'package:space_shutter/player_progress/player_progress.dart';
import 'package:space_shutter/style/style.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({
    Key? key,
    required this.worlds,
  }) : super(key: key);

  final GameWorld worlds;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final levels = worlds.levels;
    // final playerProgress = context.watch<PlayerProgress>();

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      'assets/images/backgrounds/${worlds.name}.png'),
                  fit: BoxFit.fitHeight)),
          child: Stack(children: [
            Positioned(
              top: size.height / 6,
              left: size.width * .1,
              child: Text(
                worlds.name,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            GridView.count(
              padding: EdgeInsets.fromLTRB(40, size.height / 4, 40, 0),
              crossAxisCount: 3,
              children: List.generate(
                levels.length,
                (index) {
                  return Container(
                    color: Colors.white12,
                    child: Center(
                        child: Stack(children: [
                      // playerProgress.levels.length >= levels[index].number - 1
                      levels.length > 1
                          ? WobblyButton(
                              onPressed: () {
                                context.go(
                                    '/levels/${worlds.number}/${levels[index].number}');
                              },
                              child: Text(
                                levels[index].number.toString(),
                                style: Theme.of(context).textTheme.displayLarge,
                              ))
                          : Stack(children: [
                              ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.black45.withOpacity(0.5),
                                  BlendMode.srcATop,
                                ),
                                child: WobblyButton(
                                  onPressed: () {},
                                  child: Text(
                                    levels[index].number.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ),
                              ),
                              const Positioned(
                                  child: Icon(Icons.block,
                                      size: 30,
                                      color: Color.fromARGB(255, 255, 26, 26))),
                            ]),
                    ])
                        //  TextButton(
                        //     style: ButtonStyle(
                        //       backgroundColor: MaterialStateProperty.all(
                        //           const Color.fromARGB(255, 43, 170, 164)),
                        //       minimumSize: MaterialStateProperty.all(
                        //           const Size(70.0, 70.0)),
                        //       shape: MaterialStateProperty.all(
                        //         const RoundedRectangleBorder(
                        //           side:
                        //               BorderSide(color: Colors.black, width: 6.0),
                        //         ),
                        //       ),
                        //     ),
                        //     onPressed: () {
                        //       context.go(
                        //           '/levels/${worlds.number}/${levels[index].number}');
                        //     },
                        //     child: Text(
                        //       levels[index].number.toString(),
                        //       style: Theme.of(context).textTheme.headlineSmall,
                        //     )),
                        ),
                  );
                },
              ),
            ),
            Positioned(
              right: 50,
              top: 20,
              child: WobblyButton(
                onPressed: () {
                  GoRouter.of(context).go('/play');
                },
                child: const Text('Back'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
