import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:flame/input.dart';
import 'package:flame/sprite.dart';

import '../../game/serenety_village_game.dart';
import 'cat_walk_sprite_sheet.dart';

class CatComponent extends SpriteAnimationComponent
    with GestureHitboxes, HasGameRef<SerenetyVillageGame>, Tappable {
  static const double _sizeMultiplier = 0.4;
  static const double _stepTime = 0.13;

  CatComponent() {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    size = CatWalkSpriteSheet.spriteSize * _sizeMultiplier;
    return super.onLoad();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    gameRef.showMessage('meow');
    return true;
  }

  Future<void> _createAnimation() async {
    final SpriteSheet walkSpriteSheet = SpriteSheet(
      image: await gameRef.images.load(CatWalkSpriteSheet.imagePath),
      srcSize: CatWalkSpriteSheet.spriteSize,
    );

    final SpriteAnimation walkAnimation = walkSpriteSheet.createAnimation(
      row: CatWalkSpriteSheet.walkAnimationRowIndex,
      stepTime: _stepTime,
      to: CatWalkSpriteSheet.spritesInRow,
    );

    animation = walkAnimation;
  }
}
