import 'package:clean_arch/presentation/screens/cart-screen.dart';
import 'package:clean_arch/presentation/screens/cat-screen.dart';
import 'package:clean_arch/presentation/screens/home-screen.dart';
import 'package:clean_arch/presentation/screens/profile-screens/profile-screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  int selectedScreen = 0;

  final List<Widget> screen = [
    const HomePage(),
    const CatScreen(),
    const CartPage(),
    const ProfilePage(),
  ];

  void selectScreen(int index) {
    selectedScreen = index;
    update();
  }
}
