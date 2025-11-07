import 'package:flutter/material.dart';
import 'screen/home.dart'; // Import the HomeScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Home Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(), // Use the imported HomeScreen
    );
  }
}
