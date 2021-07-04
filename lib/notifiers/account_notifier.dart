import 'package:flutter/material.dart';
import '../models/account_model.dart';
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
    await db.insertAccount(account);
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