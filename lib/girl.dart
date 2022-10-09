import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'core_ui/design/app_images.dart';

class NinjaGirlGlade extends FlameGame {
  Future<SpriteAnimationComponent> getSpriteAnimation() async {
    final Vector2 textureSize = Vector2(505, 474);
    const double scaleFactor = 0.4;
    final ui.Image girlSpriteSheet = await images.load(AppImages.ninjaGirlGlide);
    final SpriteAnimationData data =
        SpriteAnimationData.sequenced(amount: 9, stepTime: 0.04, textureSize: textureSize);
    return SpriteAnimationComponent.fromFrameData(girlSpriteSheet, data)
      ..x = 30
      ..y = 30
      ..size = textureSize * scaleFactor;
  }
}
