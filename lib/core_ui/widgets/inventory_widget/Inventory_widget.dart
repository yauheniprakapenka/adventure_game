import 'package:flutter/material.dart';

import 'inventory_button.dart';
import 'inventory_menu_widget.dart';

class InventoryWidget extends StatefulWidget {
  const InventoryWidget({super.key});

  @override
  State<InventoryWidget> createState() => _InventoryWidgetState();
}

class _InventoryWidgetState extends State<InventoryWidget> {
  bool _isInventoryVisible = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 80,
            left: 12,
            child: InventoryButton(
              onPressed: () {
                setState(() {
                  _isInventoryVisible = !_isInventoryVisible;
                });
              },
            )),
        _isInventoryVisible
            ? const Positioned.fill(
                child: Center(
                  child: InventoryMenu(),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
