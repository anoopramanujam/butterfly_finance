import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class TransactionNotifier with ChangeNotifier {
  final List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions {
    return _transactions;
  }

  TransactionModel getTransaction(int index) {
    return _transactions[index];
  }

  void add(TransactionModel transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  void delete(int i) {
    _transactions.removeAt(i);
    notifyListeners();
  }

  void update(TransactionModel transaction, int index) {
    _transactions[index] = transaction;
    notifyListeners();
  }
}
