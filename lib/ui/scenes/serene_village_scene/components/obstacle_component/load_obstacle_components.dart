import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';

import '../../game/serenety_village_game.dart';
import '../../tiled_maps/serene_village_tiled_map/serene_village_tiled_map.dart';
import 'obstacle_component.dart';

Future<void> loadObstacleComponents({
  required TiledComponent homeMap,
  required SerenetyVillageGame game,
}) async {
  final ObjectGroup? objectGroup =
      homeMap.tileMap.getLayer<ObjectGroup>(SereneVillageTiledMap.obstaclesGroupName);
  if (objectGroup != null) {
    for (final TiledObject tiledObject in objectGroup.objects) {
      final component = ObstacleComponent()
        ..position = Vector2(tiledObject.x, tiledObject.y)
        ..width = tiledObject.width
        ..height = tiledObject.height;
      game.components.add(component);
    }
  }
}
