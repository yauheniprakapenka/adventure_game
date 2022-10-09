import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'core_ui/design/app_images.dart';

class NinjaBoyIdle extends FlameGame {
  Future<SpriteAnimationComponent> getSpriteAnimation(Vector2 screenSize) async {
    final Vector2 textureSize = Vector2(232, 439);
    const double scaleFactor = 0.4;
    final ui.Image girlSpriteSheet = await images.load(AppImages.hinjaBoyIdle);
    final SpriteAnimationData data =
        SpriteAnimationData.sequenced(amount: 10, stepTime: 0.08, textureSize: textureSize);
    return SpriteAnimationComponent.fromFrameData(girlSpriteSheet, data)
      ..x = 100
      ..y = screenSize[1] - 330
      ..anchor = Anchor.center
      ..size = textureSize * scaleFactor;
  }
}
