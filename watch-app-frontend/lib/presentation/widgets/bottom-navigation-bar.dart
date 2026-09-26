import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomNavBar extends StatelessWidget {
  final Function(int) onTabChange;
  final int selectedIndex;

  const CustomNavBar({
    Key? key,
    required this.onTabChange,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: GNav(
          gap: 8,
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: const Color(0xFFAF6767),
          // tabBackgroundColor: Colors.grey[800]!,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          selectedIndex: selectedIndex,
          onTabChange: onTabChange,
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: "Home",
            ),
            GButton(
              icon: Icons.category_outlined,
              text: "Categories",
            ),
            GButton(
              icon: Icons.shopping_basket_outlined,
              text: "Cart",
            ),
            GButton(
              icon: Icons.person_outlined,
              text: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
