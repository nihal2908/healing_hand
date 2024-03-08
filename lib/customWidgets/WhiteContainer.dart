import 'package:flutter/material.dart';

class WhiteContainer extends StatelessWidget {
  final Widget child;

  WhiteContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25),
      ),
      child: child,
    );
  }
}