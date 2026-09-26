import 'package:clean_arch/presentation/controller/watch_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  final String title;
  final VoidCallback onMenuPressed; // Callback when hamburger menu is pressed
  final bool cat;

  const Header(
      {Key? key,
      required this.title,
      required this.onMenuPressed,
      this.cat = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.25,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: onMenuPressed, // Handles the menu button press
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Merriweather',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            cat
                ? GetBuilder(
                    init: WatchController(),
                    builder: (watchcontroller) {
                      return TextField(
                        onChanged: (value) =>
                            watchcontroller.filterProducts(value),
                        decoration: InputDecoration(
                          hintText: "Search watches...",
                          prefixIcon: Icon(Icons.search,
                              color: Colors.brown), // Icon on the left
                          filled: true,
                          fillColor: Colors.white, // Background color
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                            borderSide: BorderSide.none, // Remove border
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16), // Padding inside field
                        ),
                        style: TextStyle(
                            fontSize: 16, color: Colors.black), // Text style
                      );
                    })
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
