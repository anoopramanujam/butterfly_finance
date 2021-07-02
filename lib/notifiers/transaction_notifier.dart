import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../utils/db_helper.dart';

class TransactionNotifier with ChangeNotifier {
  final db = DatabaseHelper();

  Future<List<TransactionModel>> get transactions async {
    final transactions = await db.getTransactions();
    return transactions;
  }

  Future<TransactionModel> getTransaction(int txnId) async {
    final transaction = await db.getTransaction(txnId);
    return transaction;
  }

  Future<void> add(TransactionModel transaction) async {
    await db.insertTransaction(transaction);
    notifyListeners();
  }

  Future<void> delete(int txnId) async {
    await db.deleteTransaction(txnId);
    notifyListeners();
  }

  Future<void> update(TransactionModel transaction, int txnId) async {
    await db.updateTransaction(transaction, txnId);
    notifyListeners();
  }
}
