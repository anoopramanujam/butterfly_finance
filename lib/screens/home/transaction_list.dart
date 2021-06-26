import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../models/transaction_model.dart';
import '../../notifiers/transaction_notifier.dart';
import '../transactions/transaction_screen.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  Future<List<TransactionModel>>? transactions;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    transactions = Provider.of<TransactionNotifier>(context).transactions;
  }

  @override
  Widget build(BuildContext context) {
    // TransactionNotifier txnNotifier = context.watch<TransactionNotifier>();
    //  = txnNotifier.transactions;
    // return ListView.builder(
    //     itemCount: transactions.length,
    //     itemBuilder: (BuildContext _context, int i) {
    //       return _buildRow(transactions, i, txnNotifier, _context);
    //     });
    //transactions = context.watch<TransactionNotifier>().transactions;
    return FutureBuilder<List<TransactionModel>>(
        future: transactions,
        builder: (BuildContext context,
            AsyncSnapshot<List<TransactionModel>> snapshot) {
          if (snapshot.hasData) {
            final realTransactions = snapshot.data ?? [];
            final listTransactions =
                realTransactions.asMap().entries.map((transactionMap) {
              //realTransactions.asMap().entries.map((transactionMap) {
              return _buildRow(transactionMap.value, context);
            });
            final divided = realTransactions.isNotEmpty
                ? ListTile.divideTiles(
                        tiles: listTransactions, context: context)
                    .toList()
                : <Widget>[];
            return ListView(children: divided);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _buildRow(TransactionModel transaction, BuildContext context) {
    final String txnDate = DateFormat.yMMMMd().format(transaction.txnDate);
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(color: Constants.colorDeleteSwipes),
      onDismissed: (direction) async {
        //txnNotifier.delete(index);
        await context.read<TransactionNotifier>().delete(transaction.txnId);
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text('Transaction deleted')));
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
                      transaction: TransactionModel(txnDate: DateTime.now()),
                    )),
          );
        },
      )),
    );
  }
}
