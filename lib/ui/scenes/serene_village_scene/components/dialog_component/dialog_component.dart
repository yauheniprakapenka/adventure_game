import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class DialogComponent extends TextBoxComponent {
  static const double _timePerChar = 0.1;

  DialogComponent({super.text, super.position})
      : super(
          textRenderer:
              TextPaint(style: TextStyle(fontSize: 18, color: BasicPalette.white.color)).copyWith(
            (style) => style.copyWith(
              color: Colors.lightGreenAccent,
              fontFamily: 'vt323',
              letterSpacing: 2.0,
            ),
          ),
          boxConfig: TextBoxConfig(
            maxWidth: 100,
            timePerChar: _timePerChar,
          ),
        );

  @override
  void drawBackground(Canvas c) {
    const Rect rect = Rect.fromLTWH(0, 0, 100, 100);
    c.drawRect(rect, Paint()..color = Colors.black.withOpacity(0.7));
  }

  @override
  Future<void> onLoad() async {
    Duration duration =
        Duration(milliseconds: (_timePerChar * 100).toInt() * text.length) + const Duration(seconds: 1);
    Future.delayed(duration).then((value) {
      removeFromParent();
    });
    return redraw();
  }
}
