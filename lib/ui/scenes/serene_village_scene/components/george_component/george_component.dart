import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../../../../core_ui/movement_state.dart';
import '../../../../../core_ui/screen.dart';
import '../../game/serenety_village_game.dart';
import 'george_sprite_sheet.dart';

class GeorgeComponent extends SpriteAnimationComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<SerenetyVillageGame> {
  late final SpriteAnimation _walkDown;
  late final SpriteAnimation _walkLeft;
  late final SpriteAnimation _walkRight;
  late final SpriteAnimation _walkUp;
  late final SpriteAnimation _idle;

  static const double _speed = 2.5;
  static const double _stepTime = 0.2;
  static const double _relationToSpriteSize = 0.7;
  static const int _desiredNumberOfSpritesInRowForIdleAnimation = 1;
  static const double _sizeMultiplier = 1.2;

  Vector2 get _componentSize => Vector2.all(GeorgeSpriteSheet.spriteSize) * _sizeMultiplier;

  GeorgeComponent() {
    add(
      RectangleHitbox.relative(
        Vector2.all(_relationToSpriteSize),
        parentSize: _componentSize,
      ),
    );
  }

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    animation = _idle;
    size = _componentSize;
    anchor = Anchor.center;
    debugMode = true;
    await super.onLoad();
  }

  @override
  void update(double dt) {
    _updateMovement();
    super.update(dt);
  }

  void _updateMovement() {
    animation = _idle;
    switch (gameRef.georgeMovementState) {
      case kWalkDown:
        if (y < gameRef.mapSize.height - height) {
          if (gameRef.collisionDirection != kWalkDown) {
            y += _speed;
            animation = _walkDown;
          }
        }
        break;
      case kWalkLeft:
        final bool notReachedLeftScreenEdge = x > kStartXPosition;
        if (notReachedLeftScreenEdge) {
          if (gameRef.collisionDirection != kWalkLeft) {
            animation = _walkLeft;
            x -= _speed;
          }
        }
        break;
      case kWalkUp:
        if (y > kStartYPosition) {
          if (gameRef.collisionDirection != kWalkUp) {
            animation = _walkUp;
            y -= _speed;
          }
        }
        break;
      case kWalkRight:
        if (x < gameRef.mapSize.width - width) {
          if (gameRef.collisionDirection != kWalkRight) {
            animation = _walkRight;
            x += _speed;
          }
        }
        break;
    }
  }

  Future<void> _createAnimation() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(GeorgeSpriteSheet.imagePath),
      srcSize: Vector2.all(GeorgeSpriteSheet.spriteSize),
    );

    _walkDown = spriteSheet.createAnimation(
      row: GeorgeSpriteSheet.goDownAnimationRowIndex,
      stepTime: _stepTime,
      to: GeorgeSpriteSheet.spritesInRow,
    );

    _walkLeft = spriteSheet.createAnimation(
      row: GeorgeSpriteSheet.goLeftAnimationRowIndex,
      stepTime: _stepTime,
      to: GeorgeSpriteSheet.spritesInRow,
    );

    _walkUp = spriteSheet.createAnimation(
      row: GeorgeSpriteSheet.goUpAnimationRowIndex,
      stepTime: _stepTime,
      to: GeorgeSpriteSheet.spritesInRow,
    );

    _walkRight = spriteSheet.createAnimation(
      row: GeorgeSpriteSheet.goRightAnimationRowIndex,
      stepTime: _stepTime,
      to: GeorgeSpriteSheet.spritesInRow,
    );

    _idle = spriteSheet.createAnimation(
      row: GeorgeSpriteSheet.goDownAnimationRowIndex,
      stepTime: _stepTime,
      to: _desiredNumberOfSpritesInRowForIdleAnimation,
    );
  }
}
