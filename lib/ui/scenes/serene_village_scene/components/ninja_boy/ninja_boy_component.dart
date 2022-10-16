import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/sprite.dart';

import '../../../../../core_ui/movement_direction.dart';
import '../../game/serenety_village_game.dart';
import '../george_component/george_component.dart';
import 'ninja_boy_idle_direction_timer.dart';
import 'ninja_boy_sprite_sheet.dart';

class NinjaBoyComponent extends SpriteAnimationComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<SerenetyVillageGame> {
  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _runAnimation;

  static const double _idleAnimationStepTime = 0.08;
  static const double _runAnimationStepTime = 0.08;

  static const double _idleSpriteSizeMultiplier = 0.13;
  static const double _runSpriteSizeMultiplier = 0.63;

  static const int _movementSpeed = 3;

  int _movementDirection = kDirectionLeftIndex;
  final NinjaBoyIdleDirectionTimer _idleMovementTimer = NinjaBoyIdleDirectionTimer();

  NinjaBoyComponent() {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    animation = _idleAnimation;
    anchor = Anchor.center;
    // debugMode = true;
    flipHorizontally();
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
    final SpriteSheet idleSpriteSheet = SpriteSheet(
      image: await gameRef.images.load(NinjaBoyIdleSpriteSheet.imagePath),
      srcSize: NinjaBoyIdleSpriteSheet.spriteSize,
    );

    final SpriteSheet runSpriteSheet = SpriteSheet(
      image: await gameRef.images.load(NinjaBoyRunSpriteSheet.imagePath),
      srcSize: NinjaBoyRunSpriteSheet.spriteSize,
    );

    _idleAnimation = idleSpriteSheet.createAnimation(
      row: NinjaBoyIdleSpriteSheet.idleAnimationRowIndex,
      stepTime: _idleAnimationStepTime,
      to: NinjaBoyIdleSpriteSheet.spritesInRow,
    );

    _runAnimation = runSpriteSheet.createAnimation(
      row: NinjaBoyRunSpriteSheet.runAnimationRowIndex,
      stepTime: _runAnimationStepTime,
    );
  }

  void _updateMovement() {
    if (_movementDirection == kDirectionIdleIndex) {
      size = NinjaBoyIdleSpriteSheet.spriteSize * _idleSpriteSizeMultiplier;
      if (_idleMovementTimer.isFinished) {
        _movementDirection = kDirectionLeftIndex;
        _idleMovementTimer.stop();
        flipHorizontally();
      } else {
        return;
      }
    }

    if (_movementDirection == kDirectionRightIndex) {
      animation = _runAnimation;
      if (x < gameRef.centralBeachSelection.right) {
        x += _movementSpeed;
      } else {
        _movementDirection = kDirectionIdleIndex;
        animation = _idleAnimation;
        _idleMovementTimer.start();
      }
      return;
    }

    if (_movementDirection == kDirectionLeftIndex) {
      animation = _runAnimation;
      size = NinjaBoyRunSpriteSheet.spriteSize * _runSpriteSizeMultiplier;
      if (x > gameRef.centralBeachSelection.left) {
        x -= _movementSpeed;
      } else {
        flipHorizontally();
        _movementDirection = kDirectionRightIndex;
      }
      return;
    }

    throw Exception('Unknown movement direction');
  }
}
