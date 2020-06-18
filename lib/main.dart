import 'package:flutter/material.dart';
import 'package:my_day/Welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Day',
      home: WelcomePage(),
    );
  }
}
