import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';

import '../../../../../geogre_game/george_game.dart';
import '../../tiled_maps/serene_village_tiled_map/serene_village_tiled_map.dart';
import 'obstacle_component.dart';

Future<void> loadObstacleComponents(TiledComponent homeMap, GeorgeGame game) async {
  
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
