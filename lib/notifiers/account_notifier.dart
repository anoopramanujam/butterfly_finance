import 'package:butterfly_finance/utils/constants.dart';
import 'package:flutter/material.dart';
import '../models/account_model.dart';
import '../models/transaction_model.dart';
import '../utils/db_helper.dart';

class AccountNotifier with ChangeNotifier {
  final db = DatabaseHelper();

  Future<List<AccountModel>> getAllAccounts() async {
    final accounts = await db.getAllAccounts();
    return accounts;
  }

  Future<List<AccountModel>> getAccounts(int accountType) async {
    final accounts = await db.getAccounts(accountType);
    return accounts;
  }

  Future<AccountModel> getAccount(int accountId) async {
    final account = await db.getAccount(accountId);
    return account;
  }

  Future<void> add(AccountModel account) async {
    int accountId = await db.insertAccount(account);
    final transaction = TransactionModel(
        txnDate: DateTime.now(),
        description: 'Initial ' + account.name + ' Balance',
        fromAccount: Constants.accountValueBalance,
        toAccount: accountId,
        type: Constants.txnTransfer);
    await db.insertTransaction(transaction);
    notifyListeners();
  }

  Future<void> delete(int accountId) async {
    await db.deleteAccount(accountId);
    notifyListeners();
  }

  Future<void> update(AccountModel account, int accountId) async {
    await db.updateAccount(account, accountId);
    notifyListeners();
  }
}
