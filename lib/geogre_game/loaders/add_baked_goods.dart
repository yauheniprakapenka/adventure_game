import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';

import '../characters/baked_good_component.dart';
import '../george_game.dart';

Future<void> addBakedGoods(TiledComponent homeMap, GeorgeGame game) async {
  final ObjectGroup? bakedGoodsGroup = homeMap.tileMap.getLayer<ObjectGroup>('BakedGoods');
  for (final bakedGoodBox in bakedGoodsGroup!.objects) {
    final imagePath = bakedGoodBox.class_.classToImagePath();
    if (imagePath.isEmpty) {
      return;
    } else {
      final sprite = await game.loadSprite(imagePath);
      final bakedGood = BakedGoodComponent(name: bakedGoodBox.name)
        ..position = Vector2(bakedGoodBox.x, bakedGoodBox.y)
        ..sprite = sprite
        ..width = bakedGoodBox.width
        ..height = bakedGoodBox.height;
      game.componentList.add(bakedGood);
      ;
    }
  }
}

extension ClassToImagePathExtension on String {
  String classToImagePath() {
    if (this == 'apple_type') {
      return 'apple_pie2.png';
    } else if (this == 'choko_type') {
      return 'choko_cake2.png';
    } else {
      return '';
    }
  }
}
