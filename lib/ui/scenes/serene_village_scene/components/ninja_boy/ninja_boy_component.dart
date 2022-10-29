import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/sprite.dart';

import '../../../../../core_ui/movement_state.dart';
import '../../game/serenety_village_game.dart';
import '../../models/quest_model.dart';
import '../george_component/george_component.dart';
import 'ninja_boy_idle_direction_timer.dart';
import 'ninja_boy_sprite_sheet.dart';

class NinjaBoyComponent extends SpriteAnimationComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<SerenetyVillageGame> {
  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _runAnimation;
  late final SpriteAnimation _deadAnimation;

  static const double _idleAnimationStepTime = 0.08;
  static const double _runAnimationStepTime = 0.08;
  static const double _deadAnimationStepTime = 0.08;

  static const double _idleSpriteSizeMultiplier = 0.13;
  static const double _runSpriteSizeMultiplier = 0.63;
  static const double _deadSpriteSizeMultiplier = 0.13;

  static const double _movementSpeed = 1.3;
  static const double _centralBeachSelectionPadding = 32.0;

  int _movementState = kWalkLeft;
  final NinjaBoyIdleDirectionTimer _idleMovementStateTimer = NinjaBoyIdleDirectionTimer();

  NinjaBoyComponent() {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    animation = _deadAnimation;
    anchor = Anchor.center;
    debugMode = true;
    flipHorizontally();
    await super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is GeorgeComponent) {
      gameRef.showOtherMessage('Уходи', position);
      if (gameRef.stateController.hasBearToy &&
          gameRef.questController.getCurrentQuest.questType == QuestType.returnBearToyToNinjaBoy) {
        gameRef.showMessage('You find my bear toy! Thank you');
        gameRef.questController.completeCurrentQuest();
        animation = _deadAnimation;
        _movementState = kDead;
        _idleMovementStateTimer.stop();
      } else {
        gameRef.showMessage('Can you help me to find my bear toy');
      }
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    _updateMovement();
    // if (gameRef.questController.getCurrentQuest.questType == QuestType.returnBearToyToNinjaBoy) {
    //   if (gameRef.stateController.hasBearToy) {
    //     animation = _deadAnimation;
    //     _movementState = kDead;
    //     _idleMovementStateTimer.stop();
    //   }
    // }

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

    final SpriteSheet deadSpriteSheet = SpriteSheet(
      image: await gameRef.images.load(NinjaBoyDeadSpriteSheet.imagePath),
      srcSize: NinjaBoyDeadSpriteSheet.spriteSize,
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

    _deadAnimation = deadSpriteSheet.createAnimation(
      row: NinjaBoyDeadSpriteSheet.deadAnimationRowIndex,
      stepTime: _deadAnimationStepTime,
      loop: false,
    );
  }

  void _updateMovement() {
    if (_movementState == kIdle) {
      size = NinjaBoyIdleSpriteSheet.spriteSize * _idleSpriteSizeMultiplier;
      if (_idleMovementStateTimer.isFinished) {
        _movementState = kWalkLeft;
        _idleMovementStateTimer.reset();
        flipHorizontally();
      }
      return;
    }

    if (_movementState == kDead) {
      size = NinjaBoyDeadSpriteSheet.spriteSize * _deadSpriteSizeMultiplier;
      return;
    }

    if (_movementState == kWalkRight) {
      animation = _runAnimation;
      if (x < gameRef.centralBeachSelection.right - _centralBeachSelectionPadding) {
        x += _movementSpeed;
      } else {
        _movementState = kIdle;
        animation = _idleAnimation;
        _idleMovementStateTimer.start();
      }
      return;
    }

    if (_movementState == kWalkLeft) {
      animation = _runAnimation;
      size = NinjaBoyRunSpriteSheet.spriteSize * _runSpriteSizeMultiplier;
      if (x > gameRef.centralBeachSelection.left + _centralBeachSelectionPadding) {
        x -= _movementSpeed;
      } else {
        flipHorizontally();
        _movementState = kWalkRight;
      }
      return;
    }
  }
}
