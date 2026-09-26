import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final Icon? icon; // Icon can be nullable, but should be a widget

  const CustomTextButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.color,
      required this.onPressed,
      required this.text,
      required this.textColor,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centering the text and icon
          children: [
            if (icon != null) ...[
              // Only show the icon if it's provided
              Icon(
                icon!.icon, // Use the passed icon
                color: Colors.white, // Set the color to white
                size: 18, // You can customize the size if needed
              ),
              SizedBox(width: 8), // Optional spacing between the icon and text
            ],
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontFamily: 'Merriweather',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
