import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final ImageProvider image;
  final void Function()? onTap;
  CircleImage({required this.image, this.onTap});

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
          onTap: onTap ?? null,
          borderRadius: BorderRadius.circular(32),
          child: CircleAvatar(
            radius: 32.0,
            backgroundImage: image,
          ),
        ),
      ),
    );
  }
}