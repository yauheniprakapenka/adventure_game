import 'dart:math';

import 'package:vector_math/vector_math_64.dart';

/// calculate angle between two Vector points, such as a sprite position
/// and a tap position in Flutter Flame. 0 degrees points straight up.
double getAngle(Vector2 spritePosition, Vector2 tapPosition) {
  final bool tapAboveSprite = spritePosition.y > tapPosition.y;
  final bool tapAtSpriteHeight = spritePosition.y == tapPosition.y;
  final bool tapLeftOfSprite = spritePosition.x > tapPosition.x;
  final bool tapSpriteHorizCenter = spritePosition.x == tapPosition.x;

  final opposite = (tapPosition.y - spritePosition.y).abs();
  final adjacent = (spritePosition.x - tapPosition.x).abs();
  // print('opposite = $opposite, adjacent = $adjacent');

  var angle = degrees(atan(opposite / adjacent));

  if (tapAtSpriteHeight) {
    // print('tap at height');

    if (tapLeftOfSprite) {
      angle = 270;
      return radians(angle);
    } else {
      // print('set to 90 degrees');
      angle = 90;
      return radians(angle);
    }
  }

  if (tapLeftOfSprite && !tapSpriteHorizCenter) {
    // print('tapped to the left of sprite');
    // print('original angle $angle');
    angle += 90;
    if (!tapAboveSprite && !tapAtSpriteHeight) {
      // print(270 - (angle - 90));
      angle = 270 - (angle - 90);
      return radians(angle);
    } else if (tapAboveSprite && !tapAtSpriteHeight) {
      angle += 180;
      return radians(angle);
    }
  }

  if (!tapLeftOfSprite && !tapSpriteHorizCenter) {
    if (!tapAboveSprite && !tapAtSpriteHeight) {
      // print('right, below');
      angle += 90;
    } else {
      angle = 90 - angle;
    }
  }

  if (tapSpriteHorizCenter && !tapAboveSprite) {
    angle = 180;
  } else if (tapSpriteHorizCenter && tapAboveSprite) {
    angle = 0;
  }
  return radians(angle);
}

double getShortAngle(double spriteAngle, double moveAngle) {
  if (spriteAngle - moveAngle < -pi) {
    return (2 * pi - moveAngle) * -1;
  }
  return moveAngle;
}