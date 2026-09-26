import 'package:flutter/material.dart';

class GridContainerSection extends StatelessWidget {
  final String categoryTitle; // Title for the category
  final VoidCallback
      onSeeAllPressed; // Function to call when "See All" is pressed
  final int itemCount; // Number of items to show in the grid

  const GridContainerSection({
    Key? key,
    required this.categoryTitle,
    required this.onSeeAllPressed,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 10), // Add margin to the left and right
      child: Column(
        children: [
          // Row for dynamic Category Title and See All Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Libre Baskerville',
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: onSeeAllPressed,
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFFAF6767)), // Set text color
                ),
                child: const Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Libre Baskerville',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10), // Space between row and grid

          // GridView
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: GridView.builder(
              shrinkWrap: true, // Important to avoid infinite height issues
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling for GridView inside SingleChildScrollView
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 10, // Space between columns
                mainAxisSpacing: 10, // Space between rows
                childAspectRatio: 1.0, // Aspect ratio for grid items
              ),
              itemCount: itemCount, // Number of items to show (dynamic)
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Item $index', // Content of grid item
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
