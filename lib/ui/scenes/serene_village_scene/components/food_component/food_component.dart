import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../../../../core_ui/rotation.dart';
import '../../game/serenety_village_game.dart';

class FoodComponent extends SpriteComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<SerenetyVillageGame> {
  Rotation _rotation = Rotation.clockwise;
  static const double _rotationSpeed = 0.01;
  static const double _piDivider = 8.0;

  FoodComponent() {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    anchor = Anchor.center;
    debugMode = true;
    await super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    gameRef.stateController.increasePies();
    gameRef.audioController.playPickUpItem();
    removeFromParent();
    gameRef.refreshWidget();
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    if (_rotation == Rotation.clockwise) {
      if (angle < pi / _piDivider) {
        angle += _rotationSpeed;
      } else {
        _rotation = Rotation.counterClockwise;
      }
    } else if (_rotation == Rotation.counterClockwise) {
      if (angle > 0) {
        angle -= _rotationSpeed;
      } else {
        _rotation = Rotation.clockwise;
      }
    }

    super.update(dt);
  }
}
