import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';

import '../../game/serenety_village_game.dart';
import '../../tiled_maps/serene_village_tiled_map/serene_village_tiled_map.dart';
import 'obstacle_component.dart';

Future<void> loadObstacleComponents(TiledComponent homeMap, SerenetyVillageGame game) async {
  final ObjectGroup? obstaclesObjectGroup =
      homeMap.tileMap.getLayer<ObjectGroup>(SereneVillageTiledMap.obstaclesGroupName);
  final bool isObstaclesObjectGroupExist = obstaclesObjectGroup != null;
  if (isObstaclesObjectGroupExist) {
    for (final obstacleBox in obstaclesObjectGroup.objects) {
      final obstacle = ObstacleComponent()
        ..position = Vector2(obstacleBox.x, obstacleBox.y)
        ..width = obstacleBox.width
        ..height = obstacleBox.height;
      game.components.add(obstacle);
    }
  }
}
