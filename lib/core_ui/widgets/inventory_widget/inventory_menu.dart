import 'package:flutter/material.dart';

class InventoryMenu extends StatelessWidget {
  const InventoryMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: Colors.black.withOpacity(0.8),
      child: Column(
        children: const [
          Text(
            'Инвентарь',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
