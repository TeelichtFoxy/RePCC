import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class AppColorScheme {
  static const colorb = Colors.black;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RePCC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LogInPage(),
    );
  }
}

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Top Safe Space
          Align(
            alignment: Alignment.topCenter,
            child: Container(width: 390, height: 50, color: Colors.blue),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(width: 390, height: -50, color: Colors.blue),
          ),
        ],
      )
    );
  }
}