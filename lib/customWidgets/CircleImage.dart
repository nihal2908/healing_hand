import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String imagePath;
  CircleImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      height: 70.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
        child: CircleAvatar(
          radius: 32.0,
          backgroundImage: AssetImage(imagePath),
        ),
      ),
    );
  }
}