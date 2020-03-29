import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(MonopolyApp());
}

class MonopolyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: HomeScreen()
    );
  }
}