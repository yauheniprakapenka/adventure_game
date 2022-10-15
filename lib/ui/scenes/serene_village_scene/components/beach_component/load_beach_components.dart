import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';

import '../../tiled_maps/serene_village_tiled_map/serene_village_tiled_map.dart';
import 'beach_component.dart';

Future<List<BeachComponent>> loadBeachComponents({required TiledComponent homeMap}) async {
  final ObjectGroup? objectGroup =
      homeMap.tileMap.getLayer<ObjectGroup>(SereneVillageTiledMap.beachGroupName);
  final List<BeachComponent> components = [];
  if (objectGroup != null) {
    for (final TiledObject tiledObject in objectGroup.objects) {
      final BeachComponent component = BeachComponent(objectName: tiledObject.class_)
        ..position = Vector2(tiledObject.x, tiledObject.y)
        ..width = tiledObject.width
        ..height = tiledObject.height;
      components.add(component);
    }
  }
  return components;
}
