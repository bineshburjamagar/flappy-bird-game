import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  const MyBird({super.key, required this.birdY});
  final double birdY;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, birdY),
      child: const Image(
        image: AssetImage(
          'assets/images/bird.png',
        ),
        width: 100.0,
        height: 100.0,
      ),
    );
  }
}
