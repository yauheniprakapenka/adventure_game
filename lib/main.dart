import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'geogre_game/george_game.dart';
import 'geogre_game/overlays/overlay_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  runApp(
    MaterialApp(
      home: Scaffold(
        body: GameWidget(
          game: GeorgeGame(),
          overlayBuilderMap: {
            kOverlayController: (BuildContext context, GeorgeGame game) {
              return OverlayController(
                game: game,
              );
            },
          },
        ),
      ),
    ),
  );
}
