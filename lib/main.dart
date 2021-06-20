import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home/home.dart';
import './notifiers/transaction_notifier.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => TransactionNotifier(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: HomeScreen(),
    );
  }
}
