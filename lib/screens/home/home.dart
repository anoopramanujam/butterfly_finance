import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/constants.dart';
import '../../models/transaction_model.dart';
import '../../screens/transactions/transaction_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<TransactionModel> transactions = [
    TransactionModel(
        txnDate: DateTime(2021, 6, 1),
        amount: 100.00,
        description: 'Tea with friends'),
    TransactionModel(
        txnDate: DateTime(2021, 6, 2),
        amount: 1200.00,
        description: 'School Fee'),
    TransactionModel(
        txnDate: DateTime(2021, 6, 3),
        amount: 500.00,
        description: 'Travel out of town'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.titleHome),
      ),
      body: (ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (BuildContext _context, int i) {
            return _buildRow(transactions[i]);
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TransactionScreen()),
          );
        },
        child: const Icon(Icons.add),
        // backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildRow(TransactionModel transaction) {
    final String txnDate = DateFormat.yMMMMd().format(transaction.txnDate);
    return (ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(transaction.description),
          Text(transaction.amount.toStringAsFixed(Constants.decimalPlaces)),
        ],
      ),
      subtitle: Text(txnDate),
    ));
  }
}
