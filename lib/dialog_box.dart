// ? Default variant

// import 'package:flame/components.dart';
// import 'package:flutter/material.dart';

// import '../george_game.dart';

// class DialogBox extends TextBoxComponent {
//   final GeorgeGame game;

//   DialogBox({required String text, required this.game})
//       : super(
//           text: text,
//           position: game.size,
//           boxConfig: TextBoxConfig(
//             dismissDelay: 2.0,
//             maxWidth: game.size.x * 0.5,
//             timePerChar: 0.04,
//           ),
//         ) {
//     anchor = Anchor.bottomRight;
//   }

//   @override
//   void drawBackground(Canvas c) {
//     Rect rect = Rect.fromLTWH(0, 0, width, height);
//     c.drawRect(rect, Paint()..color = Colors.grey[800]!.withOpacity(0.5));
//   }

//   @override
//   void update(double dt) {
//     super.update(dt);
//     if (finished) {
//       print('removed');
//       game.remove(this);
//     }
//   }
// }
