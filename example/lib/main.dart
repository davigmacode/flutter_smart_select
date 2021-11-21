import 'package:flutter/material.dart';
import 'features.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Select',
      home: Features(),
    );
  }
}
