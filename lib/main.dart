import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Butterfly Finance'),
        ),
        body: Center(
          child: Text('Hello World',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                  fontSize: 24)),
        ),
      ),
    );
  }
}
