import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:butterfly_finance/screens/transactions/transaction_screen.dart';
import 'package:butterfly_finance/notifiers/transaction_notifier.dart';

Widget createTxnScreen() => ChangeNotifierProvider(
      create: (context) => TransactionNotifier(),
      child: MaterialApp(
        home: TransactionScreen(),
      ),
    );

void main() {
  testWidgets('Build Transction Screen', (tester) async {
    await tester.pumpWidget(createTxnScreen());
    expect(find.text('New transaction'), findsOneWidget);

    expect(find.byType(TextField), findsNWidgets(2));
  });
}
