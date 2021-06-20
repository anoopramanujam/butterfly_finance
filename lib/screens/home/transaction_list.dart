import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../models/transaction_model.dart';
import '../../notifiers/transaction_notifier.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<TransactionModel> _transactions =
        context.watch<TransactionNotifier>().transactions;
    return ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (BuildContext _context, int i) {
          return _buildRow(_transactions[i]);
        });
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
