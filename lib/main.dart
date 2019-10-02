import 'package:flutter/material.dart';
import 'package:hello_world/random-word/random-words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Random Name Generator',
      home: RandomWords(),
    );
  }
}
