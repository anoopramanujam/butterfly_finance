import 'package:butterfly_finance/models/transaction_model.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../screens/transactions/transaction_screen.dart';
import './transaction_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.titleHome),
      ),
      body: TransactionList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TransactionScreen(
                      transaction: TransactionModel(txnDate: DateTime.now()),
                    )),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
