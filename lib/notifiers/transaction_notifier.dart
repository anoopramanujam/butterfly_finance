import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class TransactionNotifier with ChangeNotifier {
  final List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions {
    return _transactions;
  }

  void add(TransactionModel transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  void delete(int i) {
    _transactions.removeAt(i);
  }
}
