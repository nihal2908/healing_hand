import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String imagePath;
  final void Function()? onTap;
  CircleImage({required this.imagePath, this.onTap});

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
        child: InkWell(
          onTap: onTap ?? (){
            print('picture tapped');
          },
          borderRadius: BorderRadius.circular(32),
          child: CircleAvatar(
            radius: 32.0,
            backgroundImage: AssetImage(imagePath),
          ),
        ),
      ),
    );
  }
}