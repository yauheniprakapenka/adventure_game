import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';

import '../../game/serenety_village_game.dart';
import '../../tiled_maps/serene_village_tiled_map/serene_village_tiled_map.dart';
import 'class_to_image_path_extension.dart';
import 'food_component.dart';

Future<void> loadFoodComponents(TiledComponent homeMap, SerenetyVillageGame game) async {
  final ObjectGroup? foodsObjectGroup = homeMap.tileMap.getLayer<ObjectGroup>(
    SereneVillageTiledMap.foodsGroupName,
  );
  if (foodsObjectGroup != null) {
    for (final object in foodsObjectGroup.objects) {
      final String imagePath = object.class_.classToImagePath();
      if (imagePath.isEmpty) {
        return;
      } else {
        final Sprite sprite = await game.loadSprite(imagePath);
        final FoodComponent foodComponent = FoodComponent(name: object.name)
          ..position = Vector2(object.x, object.y)
          ..sprite = sprite
          ..width = object.width
          ..height = object.height;
        game.components.add(foodComponent);
      }
    }
  }
}
