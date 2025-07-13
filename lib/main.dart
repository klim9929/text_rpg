import 'package:flutter/material.dart';
import 'game/ui/game_screen.dart';
import 'game/ui/settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Текстовая RPG',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => GameScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
