import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() => runApp(BeatMyScore());

class BeatMyScore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
