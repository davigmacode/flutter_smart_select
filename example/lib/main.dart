import 'package:flutter/material.dart';
import 'package:theme_patrol/theme_patrol.dart';
import 'features.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemePatrol(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
        accentColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useTextSelectionTheme: true
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
        accentColor: Colors.red,
        toggleableActiveColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useTextSelectionTheme: true
      ),
      mode: ThemeMode.system,
      builder: (context, theme) {
        return MaterialApp(
          title: 'Smart Select',
          theme: theme.light,
          darkTheme: theme.dark,
          themeMode: theme.mode,
          home: Features(),
        );
      },
    );
  }
}
