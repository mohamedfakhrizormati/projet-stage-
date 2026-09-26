import 'package:flutter/material.dart';

class HomeSelectHeader extends StatelessWidget {
  final String categoryTitle;
  final VoidCallback onSeeAllPressed;
  final bool seeAll;

  const HomeSelectHeader({
    Key? key,
    required this.categoryTitle,
    required this.onSeeAllPressed,
    this.seeAll = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          categoryTitle,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Merriweather',
            fontWeight: FontWeight.bold,
          ),
        ),
        seeAll
            ? TextButton(
                onPressed: onSeeAllPressed,
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFAF6767)), // Set text color
                ),
                child: const Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Merriweather',
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }
}
