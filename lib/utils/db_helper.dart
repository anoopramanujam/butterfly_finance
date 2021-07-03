import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transaction_model.dart';
import '../models/account_model.dart';

import 'db_scripts.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get db async => _db ??= await initializeDB();

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'butterfly_finance.db'),
      onCreate: (database, version) async {
        Batch batch = database.batch();
        DbScripts.initScripts.forEach((sql) {
          batch.execute(sql);
        });
        await batch.commit();
      },
      version: 1,
    );
  }

  Future<List<TransactionModel>> getTransactions() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('transactions', orderBy: 'txnDate DESC');
    return queryResult.map((e) => TransactionModel.fromMap(e)).toList();
  }

  Future<TransactionModel> getTransaction(int txnId) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      'transactions',
      where: 'txnId = ? ',
      whereArgs: [txnId],
    );
    return queryResult.map((e) => TransactionModel.fromMap(e)).first;
  }

  Future<int> insertTransaction(TransactionModel transaction) async {
    int result = 0;
    final Database db = await _instance.db;
    result = await db.insert('transactions', transaction.toMap());
    return result;
  }

  Future<void> deleteTransaction(int txnId) async {
    final db = await initializeDB();
    await db.delete(
      'transactions',
      where: "txnId = ?",
      whereArgs: [txnId],
    );
  }

  Future<void> updateTransaction(
      TransactionModel transaction, int txnId) async {
    final db = await initializeDB();
    await db.update(
      'transactions',
      transaction.toMap(),
      where: "txnId = ?",
      whereArgs: [txnId],
    );
  }

  Future<List<AccountModel>> getAllAccounts() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      'accounts',
      orderBy: 'type, name',
    );
    return queryResult.map((e) => AccountModel.fromMap(e)).toList();
  }

  Future<List<AccountModel>> getAccounts(int accountType) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      'accounts',
      where: 'type = ? ',
      whereArgs: [accountType],
      orderBy: 'name',
    );
    return queryResult.map((e) => AccountModel.fromMap(e)).toList();
  }

  Future<AccountModel> getAccount(int accountId) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      'accounts',
      where: 'accountId = ? ',
      whereArgs: [accountId],
    );
    return queryResult.map((e) => AccountModel.fromMap(e)).first;
  }

  Future<int> insertAccount(AccountModel account) async {
    int result = 0;
    final Database db = await _instance.db;
    result = await db.insert('accounts', account.toMap());
    return result;
  }

  Future<void> deleteAccount(int accountId) async {
    final db = await initializeDB();
    await db.delete(
      'accounts',
      where: "accountId = ?",
      whereArgs: [accountId],
    );
  }

  Future<void> updateAccount(AccountModel account, int accountId) async {
    final db = await initializeDB();
    await db.update(
      'accounts',
      account.toMap(),
      where: "accountId = ?",
      whereArgs: [accountId],
    );
  }
}
