import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:butterfly_finance/screens/home/home.dart';
import 'package:butterfly_finance/notifiers/transaction_notifier.dart';

Widget createHomeScreen() => ChangeNotifierProvider(
      create: (context) => TransactionNotifier(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );

void main() {
  testWidgets('Build Home Screen', (tester) async {
    await tester.pumpWidget(createHomeScreen());
    expect(find.text('Butterfly Finance'), findsOneWidget);
  });
}
