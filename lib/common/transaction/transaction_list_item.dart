import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../models/transaction_model.dart';
import '../../models/transaction_detail_model.dart';
import '../../notifiers/transaction_notifier.dart';
import '../../screens/transactions/transaction_screen.dart';

// Each item in the transaction list
class TransactionListItem extends StatelessWidget {
  const TransactionListItem({Key? key, required this.transactionDetail})
      : super(key: key);

  final TransactionDetailModel transactionDetail;

  @override
  Widget build(BuildContext context) {
    final String txnDate =
        DateFormat.yMMMMd().format(transactionDetail.txnDate);
    final String transferLabel = transactionDetail.fromAccountName.toString() +
        ' to ' +
        transactionDetail.toAccountName.toString();
    var currencyFormat = NumberFormat('#,###,##0.00', 'en-US');
    final String displayAmount =
        currencyFormat.format(transactionDetail.amount);
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(color: Constants.colorDeleteSwipes),
      onDismissed: (direction) async {
        await context
            .read<TransactionNotifier>()
            .delete(transactionDetail.txnId);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: const Text(Constants.infoTransactionDelete)));
      },
      child: (ListTile(
        isThreeLine: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(transactionDetail.description),
            Text(displayAmount),
          ],
        ),
        subtitle: Text(transferLabel + "\n" + txnDate),
        // subtitle: Text('bow'),
        onTap: () {
          final transaction = TransactionModel(
              txnDate: transactionDetail.txnDate,
              amount: transactionDetail.amount,
              description: transactionDetail.description,
              fromAccount: transactionDetail.fromAccount,
              toAccount: transactionDetail.toAccount,
              txnId: transactionDetail.txnId,
              type: transactionDetail.type);
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
