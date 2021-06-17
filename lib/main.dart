import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
          body: Home()),
    );
  }
}

/// Home Screen
class Home extends StatelessWidget {
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
    return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (BuildContext _context, int i) {
          return _buildRow(transactions[i]);
        });
  }

  Widget _buildRow(TransactionModel transaction) {
    final String txnDate = DateFormat.yMMMMd().format(transaction.txnDate);
    //final String txnDate = transaction.txnDate.toString();
    return (ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(transaction.description),
          Text(transaction.amount.toStringAsFixed(2)),
        ],
      ),
      subtitle: Text(txnDate),
    ));
  }
}

class TransactionModel {
  TransactionModel(
      {required this.txnDate, required this.amount, this.description = ''});

  final DateTime txnDate;
  final String description;
  final double amount;
}
