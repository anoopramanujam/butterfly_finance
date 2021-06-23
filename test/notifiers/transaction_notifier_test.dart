import 'package:flutter_test/flutter_test.dart';
import 'package:butterfly_finance/notifiers/transaction_notifier.dart';
import 'package:butterfly_finance/models/transaction_model.dart';

final demoTransactions = [
  TransactionModel(
      txnDate: DateTime(2021, 3, 14), amount: 15.0, description: 'Tea'),
  TransactionModel(
      txnDate: DateTime(2021, 6, 21), amount: 100.0, description: 'School'),
  TransactionModel(
      txnDate: DateTime(2021, 4, 14), amount: 20.0, description: 'Coffee'),
];
void main() {
  group('Transaction Model: ', () {
    test('Transaction operations', () {
      final txnNotifier = TransactionNotifier();

      // add a transaction
      txnNotifier.add(demoTransactions[0]);
      expect(txnNotifier.transactions.first.description, 'Tea');

      txnNotifier.add(demoTransactions[1]);
      expect(txnNotifier.transactions.length, 2);

      // update
      txnNotifier.update(demoTransactions[2], 0);
      expect(txnNotifier.transactions.first.description, 'Coffee');

      // delete
      txnNotifier.delete(0);
      expect(txnNotifier.transactions.length, 1);
    });
  });
}
