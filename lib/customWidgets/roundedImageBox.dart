import 'package:flutter/material.dart';

class RoundedImageBox extends StatelessWidget {
  final String imagePath;

  RoundedImageBox({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50, // Set your desired width
      height: 50, // Set your desired height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // Set the border radius
        border: Border.all(
          color: Colors.black, // Set the border color
          width: 1, // Set the border width
        ),
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
      ),
    );
  }
}