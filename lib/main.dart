// main.dart
import 'package:flutter/material.dart';
import 'package:myapp/Screens/planet_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD de Planetas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PlanetListScreen(),
    );
  }
}
