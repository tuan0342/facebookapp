import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int index;
  final void Function(int) onTap;
  const BottomNavBar({super.key, this.index = 0, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "Friend"),
        BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_fill), label: "Video"),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: "Notify"),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
      ],
      currentIndex: index,
      onTap: onTap,
    );
  }
}
