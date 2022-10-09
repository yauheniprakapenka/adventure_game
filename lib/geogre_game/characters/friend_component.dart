import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../george_game.dart';
import '../../ui/scenes/serene_village_scene/characters/george/george_component.dart';

class FriendComponent extends PositionComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<GeorgeGame> {
  final String name;

  FriendComponent({required this.name}) {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    debugMode = true;
    await super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is GeorgeComponent) {
      String dialogMessage;
      if (gameRef.pieNumber > 0) {
        dialogMessage = 'Thanks for a pie!';
        gameRef.pieNumber--;
      } else {
        dialogMessage = 'Can you find a pie?';
      }
      gameRef.dialogMessage = dialogMessage;
      gameRef.showDialog = true;
      gameRef.friendNumber++;

      if (gameRef.maxFriends <= gameRef.friendNumber) {
        gameRef.sceneNumber++;
        gameRef.newScene();
      }

      gameRef.refreshWidget();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
