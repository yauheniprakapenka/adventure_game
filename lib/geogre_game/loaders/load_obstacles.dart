import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';

import '../characters/obstacle_component.dart';
import '../george_game.dart';

const String _obstaclesObjectGroupName = 'obstacles';

Future<void> loadObstacles(TiledComponent homeMap, GeorgeGame game) async {
  final ObjectGroup? obstaclesObjectGroup =
      homeMap.tileMap.getLayer<ObjectGroup>(_obstaclesObjectGroupName);

  final bool isObstaclesObjectGroupExist = obstaclesObjectGroup != null;

  if (isObstaclesObjectGroupExist) {
    for (final obstacleBox in obstaclesObjectGroup.objects) {
      final obstacle = ObstacleComponent()
        ..position = Vector2(obstacleBox.x, obstacleBox.y)
        ..width = obstacleBox.width
        ..height = obstacleBox.height;
      game.componentList.add(obstacle);
    }
  }
}
