import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../../../../core_ui/movement_direction.dart';
import '../../game/serenety_village_game.dart';
import '../george_component/george_component.dart';
import 'ninja_boy_sprite_sheet.dart';

class NinjaBoyComponent extends SpriteAnimationComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<SerenetyVillageGame> {
  late final SpriteAnimation _idleAnimation;

  static const double _stepTime = 0.08;
  static const double _sizeMultiplier = 0.13;

  NinjaBoyComponent() {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    animation = _idleAnimation;
    size = NinjaBoySpriteSheet.spriteSize * _sizeMultiplier;
    anchor = Anchor.center;
    debugMode = true;
    await super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is GeorgeComponent) {
      gameRef.showMessage('I will catch you!');
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    _updateMovement();
    super.update(dt);
  }

  Future<void> _createAnimation() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(NinjaBoySpriteSheet.imagePath),
      srcSize: NinjaBoySpriteSheet.spriteSize,
    );

    _idleAnimation = spriteSheet.createAnimation(
      row: NinjaBoySpriteSheet.idleAnimationRowIndex,
      stepTime: _stepTime,
      to: NinjaBoySpriteSheet.spritesInRow,
    );
  }

  int movementDirection = kDirectionRightIndex;

  void _updateMovement() {
    if (movementDirection == kDirectionRightIndex) {
      if (x < gameRef.centralBeachSelection.right) {
        x += 1;
      } else {
        movementDirection = kDirectionLeftIndex;
      }
    } else if (movementDirection == kDirectionLeftIndex) {
      if (x > gameRef.centralBeachSelection.left) {
        x -= 1;
      } else {
        movementDirection = kDirectionRightIndex;
      }
    } else {
      print('unknown');
    }
  }
}

/// Example with SpriteAnimationComponent
/// 
// class NinjaBoyIdle extends FlameGame {
//   Future<SpriteAnimationComponent> getSpriteAnimation(Vector2 screenSize) async {
//     final Vector2 textureSize = Vector2(212, 339);
//     const double scaleFactor = 0.4;
//     final ui.Image girlSpriteSheet = await images.load(NinjaBoySpriteSheet.imagePath);
//     final SpriteAnimationData data =
//         SpriteAnimationData.sequenced(amount: 10, stepTime: 0.08, textureSize: textureSize);
//     return SpriteAnimationComponent.fromFrameData(girlSpriteSheet, data)
//       ..x = 100
//       ..y = screenSize[1] - 330
//       ..anchor = Anchor.center
//       ..size = textureSize * scaleFactor;
//   }
// }