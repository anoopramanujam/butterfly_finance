import 'package:flutter/material.dart';

import './utils/constants.dart';
import './screens/home/home.dart';

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
            title: const Text(Constants.appTitle),
          ),
          body: Home()),
    );
  }
}
