import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../models/transaction_model.dart';
import '../../notifiers/transaction_notifier.dart';
import '../transactions/transaction_screen.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransactionNotifier txnNotifier = context.watch<TransactionNotifier>();
    final List<TransactionModel> transactions = txnNotifier.transactions;
    return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (BuildContext _context, int i) {
          return _buildRow(transactions, i, txnNotifier, _context);
        });
  }

  Widget _buildRow(List<TransactionModel> transactions, int index,
      TransactionNotifier txnNotifier, BuildContext context) {
    final transaction = transactions[index];
    final String txnDate = DateFormat.yMMMMd().format(transaction.txnDate);
    return Dismissible(
      key: Key(transaction.description + transaction.txnDate.toString()),
      direction: DismissDirection.endToStart,
      background: Container(color: Constants.colorDeleteSwipes),
      onDismissed: (direction) {
        txnNotifier.delete(index);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Transaction deleted')));
      },
      child: (ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(transaction.description),
            Text(transaction.amount.toStringAsFixed(Constants.decimalPlaces)),
          ],
        ),
        subtitle: Text(txnDate),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TransactionScreen(
                      txnId: index,
                    )),
          );
        },
      )),
    );
  }
}
