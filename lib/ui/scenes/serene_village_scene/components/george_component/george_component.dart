import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:flame/sprite.dart';

import '../../../../../core_ui/movement_direction.dart';
import '../../../../../core_ui/design/screen.dart';
import '../../game/serenety_village_game.dart';
import 'george_sprite_sheet.dart';

class GeorgeComponent extends SpriteAnimationComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<SerenetyVillageGame> {
  late final SpriteAnimation _goDownAnimation;
  late final SpriteAnimation _goLeftAnimation;
  late final SpriteAnimation _goRightAnimation;
  late final SpriteAnimation _goUpAnimation;
  late final SpriteAnimation _idleAnimation;

  static const double _speed = 2.5;
  static const double _stepTime = 0.2;
  static const double _relationToSpriteSize = 0.7;
  static const int _desiredNumberOfSpritesInRowForIdleAnimation = 1;

  GeorgeComponent() {
    add(
      RectangleHitbox.relative(
        Vector2.all(_relationToSpriteSize),
        parentSize: Vector2.all(GeorgeSpriteSheet.spriteSize),
      ),
    );
  }

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    animation = _idleAnimation;
    size = Vector2.all(GeorgeSpriteSheet.spriteSize);
    debugMode = true;
    await super.onLoad();
  }

  @override
  void update(double dt) {
    _updateMovement();
    super.update(dt);
  }

  void _updateMovement() {
    animation = _idleAnimation;
    switch (gameRef.georgeDirection) {
      case kDirectionDownIndex:
        if (y < gameRef.mapHeight - height) {
          if (gameRef.collisionDirection != kDirectionDownIndex) {
            y += _speed;
            animation = _goDownAnimation;
          }
        }
        break;
      case kDirectionLeftIndex:
        final bool notReachedLeftScreenEdge = x > startXPosition;
        if (notReachedLeftScreenEdge) {
          if (gameRef.collisionDirection != kDirectionLeftIndex) {
            animation = _goLeftAnimation;
            x -= _speed;
          }
        }
        break;
      case kDirectionUpIndex:
        if (y > startYPosition) {
          if (gameRef.collisionDirection != kDirectionUpIndex) {
            animation = _goUpAnimation;
            y -= _speed;
          }
        }
        break;
      case kDirectionRightIndex:
        if (x < gameRef.mapWidth - width) {
          if (gameRef.collisionDirection != kDirectionRightIndex) {
            animation = _goRightAnimation;
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

    _goDownAnimation = spriteSheet.createAnimation(
      row: GeorgeSpriteSheet.goDownAnimationRowIndex,
      stepTime: _stepTime,
      to: GeorgeSpriteSheet.spritesInRow,
    );

    _goLeftAnimation = spriteSheet.createAnimation(
      row: GeorgeSpriteSheet.goLeftAnimationRRowIndex,
      stepTime: _stepTime,
      to: GeorgeSpriteSheet.spritesInRow,
    );

    _goUpAnimation = spriteSheet.createAnimation(
      row: GeorgeSpriteSheet.goUpAnimationRRowIndex,
      stepTime: _stepTime,
      to: GeorgeSpriteSheet.spritesInRow,
    );

    _goRightAnimation = spriteSheet.createAnimation(
      row: GeorgeSpriteSheet.goRightAnimationRRowIndex,
      stepTime: _stepTime,
      to: GeorgeSpriteSheet.spritesInRow,
    );

    _idleAnimation = spriteSheet.createAnimation(
      row: GeorgeSpriteSheet.goDownAnimationRowIndex,
      stepTime: _stepTime,
      to: _desiredNumberOfSpritesInRowForIdleAnimation,
    );
  }
}
