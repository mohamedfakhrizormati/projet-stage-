import 'package:clean_arch/presentation/controller/main_controller.dart';
import 'package:clean_arch/presentation/widgets/bottom-navigation-bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (mainController) {
        return Scaffold(
          body: mainController.screen[mainController.selectedScreen],
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          bottomNavigationBar: CustomNavBar(
            onTabChange: mainController.selectScreen,
            selectedIndex: mainController.selectedScreen,
          ),
        );
      },
    );
  }
}
