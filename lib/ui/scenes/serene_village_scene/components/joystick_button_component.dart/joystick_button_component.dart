import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class JoystickButtonComponent extends HudButtonComponent {
  static final Vector2 _size = Vector2.all(72.0);
  static final Vector2 _onPressedSize = Vector2.all(64.0);

  JoystickButtonComponent({
    required EdgeInsets margin,
    required Sprite sprite,
    required Function() super.onPressed,
    required Function() super.onReleased,
  }) : super(
          button: SpriteComponent(
            sprite: sprite,
            size: _size,
          ),
          buttonDown: SpriteComponent(
            position: (_size - _onPressedSize) / 2,
            sprite: sprite,
            size: _onPressedSize,
          ),
          margin: margin,
        );
}
