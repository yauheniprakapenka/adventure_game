import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'ui/scenes/serene_village_scene/game/serenety_village_game.dart';
import 'ui/scenes/serene_village_scene/widgets/scene_controller_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  runApp(
    MaterialApp(
      home: Scaffold(
        body: GameWidget(
          game: SerenetyVillageGame(),
          overlayBuilderMap: {
            kOverlayController: (BuildContext context, SerenetyVillageGame game) {
              return SceneControllerWidget(
                game: game,
              );
            },
          },
        ),
      ),
    ),
  );
}
