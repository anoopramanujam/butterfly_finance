import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/transaction_model.dart';
import '../../models/account_model.dart';
import '../../notifiers/transaction_notifier.dart';
import './transaction_list_item.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  Future<List<TransactionModel>>? transactions;
  Future<List<AccountModel>>? accounts;

  @override
  // Special Note
  //
  // Notifier changes can be consumed either here in didChangedependencies
  //  or as context.watch in build() below. But Flutter docs warn against
  //  calling Future inside build when FutureBuilder is used. Hence, putting it
  //  here. Need to relook
  void didChangeDependencies() {
    super.didChangeDependencies();
    transactions = Provider.of<TransactionNotifier>(context).transactions;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionModel>>(
        future: transactions,
        builder: (BuildContext context,
            AsyncSnapshot<List<TransactionModel>> snapshot) {
          if (snapshot.hasData) {
            final realTransactions = snapshot.data ?? [];
            final listTransactions =
                realTransactions.asMap().entries.map((transactionMap) {
              return TransactionListItem(transaction: transactionMap.value);
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
}
