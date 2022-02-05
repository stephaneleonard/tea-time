import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTap,
    Key? key,
  }) : super(key: key);

  final int selectedIndex;
  final Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTap,
      selectedItemColor: Colors.green.shade300,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.book_outlined),
          label: 'Collection',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_cafe_outlined),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}
