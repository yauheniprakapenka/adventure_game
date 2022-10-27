import 'package:flutter/material.dart';

class InventoryButton extends StatelessWidget {
  final VoidCallback onPressed;

  const InventoryButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed,
      child: Container(
        width: 44,
        height: 44,
        color: Colors.black.withOpacity(0.5),
        child: const Icon(Icons.badge, color: Colors.white),
      ),
    );
  }
}
