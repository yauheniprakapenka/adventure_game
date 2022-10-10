import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';

import '../../ui/scenes/serene_village_scene/tiled_maps/serene_village_tiled_map/serene_village_tiled_map.dart';
import '../../ui/scenes/serene_village_scene/food_component/food_component.dart';
import '../george_game.dart';

Future<void> addBakedGoods(TiledComponent homeMap, GeorgeGame game) async {
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
        ;
      }
    }
  }
}

extension ClassToImagePathExtension on String {
  String classToImagePath() {
    if (this == 'apple_pie_selection') {
      return 'serenety_village/apple_pie.png';
    } else if (this == 'choko_pie_selection') {
      return 'serenety_village/choko_pie.png';
    } else {
      return '';
    }
  }
}
