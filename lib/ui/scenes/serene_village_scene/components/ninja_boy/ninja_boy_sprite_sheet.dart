// ignore_for_file: prefer-match-file-name

import 'package:flame/components.dart';

class NinjaBoyIdleSpriteSheet {
  static const String imagePath = 'sprite_sheets/ninja_boy_idle_sprite_sheet.png';
  static final Vector2 spriteSize = Vector2(232.0, 439.0);
  static const int spritesInRow = 10;
  static const int idleAnimationRowIndex = 0;
}

class NinjaBoyRunSpriteSheet {
  static const String imagePath = 'sprite_sheets/ninja_boy_run_sprite_sheet.png';
  static final Vector2 spriteSize = Vector2.all(96.0);
  static const int spritesInRow = 10;
  static const int runAnimationRowIndex = 0;
}

class NinjaBoyDeadSpriteSheet {
  static const String imagePath = 'sprite_sheets/ninja_boy_dead_sprite_sheet.png';
  static final Vector2 spriteSize = Vector2(482.0, 498.0);
  static const int spritesInRow = 10;
  static const int deadAnimationRowIndex = 0;
}
