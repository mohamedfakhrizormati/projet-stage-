import 'package:clean_arch/presentation/screens/walcome-screens/screen-three.dart';
import 'package:flutter/material.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({Key? key}) : super(key: key);

  @override
  State<ScreenTwo> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background image container
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/watch2.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content container with gradient
          Container(
            alignment:
                Alignment.bottomLeft, // Align to the bottom-left of the screen
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black12,
                  Colors.black87,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20), // Padding for the text
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Latest fashion statement",
                    style: TextStyle(
                      fontFamily: 'Libre Baskerville',
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Universal "
                    "Timekeepers "
                    " of the world",
                    style: TextStyle(
                      fontFamily: 'Libre Baskerville',
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Button and dots container
          Positioned(
            top: 20,
            right: 32,
            left: 32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Button container
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScreenThree(),
                        ),
                      );
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Space between button and dots

                // Dots with margin and padding
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.only(right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey, // First dot color
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8), // Space between dots
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: const Color(0xFF737373), // First dot color
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8), // Space between dots
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey, // Third dot color
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
