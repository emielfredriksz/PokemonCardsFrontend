import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const TabButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 100,
        color: Colors.grey[200],
        child: Center(child: Text(label)),
      ),
    );
  }
}
