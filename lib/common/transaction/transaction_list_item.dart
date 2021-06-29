import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../models/transaction_model.dart';
import '../../notifiers/transaction_notifier.dart';
import '../../screens/transactions/transaction_screen.dart';

// Each item in the transaction list
class TransactionListItem extends StatelessWidget {
  const TransactionListItem({Key? key, required this.transaction})
      : super(key: key);

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    final String txnDate = DateFormat.yMMMMd().format(transaction.txnDate);
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(color: Constants.colorDeleteSwipes),
      onDismissed: (direction) async {
        await context.read<TransactionNotifier>().delete(transaction.txnId);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: const Text(Constants.infoTransactionDelete)));
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
                      transaction: transaction,
                    )),
          );
        },
      )),
    );
  }
}
