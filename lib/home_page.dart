import 'dart:async';

import 'package:flappy_bird_game/my_bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdY = 0;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9; // how strong the gravity is
  double velocity = 4; // how strong the jump is

  bool gameHasStarted = false;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      height = gravity * time * time + velocity * time;

      setState(() {
        birdY = initialPos - height;
      });

      //check bird is dead

      if (birdIsDead()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
      }

      //time keeps going
      time += 0.01;
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  bool birdIsDead() {
    //check if bird is hitting the top or the bottom of the screen
    if (birdY < -1 || birdY > 1) {
      return true;
    }

    //check if the bird is hitting a barrier
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.lime,
                child: Center(
                  child: Stack(
                    children: [
                      MyBird(
                        birdY: birdY,
                      ),
                      Container(
                        alignment: const Alignment(0, -0.5),
                        child: Text(
                          gameHasStarted ? '' : 'T A P   T O   P L A Y',
                          style: const TextStyle(
                              color: Colors.brown, fontSize: 20.0),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.teal,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.teal,
            title: const Center(
              child: Text(
                'G A M E   O V E R',
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    color: Colors.white,
                    child: const Text(
                      'PLAY AGAIN',
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initialPos = birdY;
    });
  }
}
