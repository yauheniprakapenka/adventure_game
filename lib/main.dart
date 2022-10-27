import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'core_ui/widgets/inventory_widget/Inventory_widget.dart';
import 'ui/scenes/serene_village_scene/game/serenety_village_game.dart';
import 'ui/scenes/serene_village_scene/widgets/scene_controller_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  final SerenetyVillageGame game = SerenetyVillageGame();

  runApp(
    MaterialApp(
      home: HomeWidget(game: game),
    ),
  );
}

class HomeWidget extends StatelessWidget {
  final SerenetyVillageGame game;

  const HomeWidget({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: SerenetyVillageGame(),
            overlayBuilderMap: {
              kOverlayController: (BuildContext _, SerenetyVillageGame game) {
                return SceneControllerWidget(
                  game: game,
                );
              },
            },
          ),
          const Positioned.fill(
            child: InventoryWidget(),
          ),
        ],
      ),
    );
  }
}
