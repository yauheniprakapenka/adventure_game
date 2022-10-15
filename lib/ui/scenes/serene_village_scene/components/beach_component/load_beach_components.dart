import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';

import '../../game/serenety_village_game.dart';
import '../../tiled_maps/serene_village_tiled_map/serene_village_tiled_map.dart';
import 'beach_component.dart';

Future<void> loadBeachComponents({
  required TiledComponent homeMap,
  required SerenetyVillageGame game,
}) async {
  final ObjectGroup? objectGroup =
      homeMap.tileMap.getLayer<ObjectGroup>(SereneVillageTiledMap.beachGroupName);
  if (objectGroup != null) {
    for (final TiledObject tiledObject in objectGroup.objects) {
      final component = BeachComponent()
        ..position = Vector2(tiledObject.x, tiledObject.y)
        ..width = tiledObject.width
        ..height = tiledObject.height;
      game.components.add(component);
    }
  }
}
