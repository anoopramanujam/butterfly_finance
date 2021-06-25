import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transaction_model.dart';

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
        await database.execute('''
              CREATE TABLE transactions (
              txnId INTEGER PRIMARY KEY AUTOINCREMENT, 
              txnDate INTEGER NOT NULL,
              description TEXT NOT NULL,
              amount REAL NOT NULL             
              )
              ''');
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
    final List<Map<String, Object?>> queryResult =
        await db.query('transactions', where: 'txnId = ? ', whereArgs: [txnId]);
    return queryResult.map((e) => TransactionModel.fromMap(e)).first;
  }

  Future<int> insertTransaction(TransactionModel transaction) async {
    int result = 0;
    final Database db = await _instance.db;
    result = await db.insert('contacts', transaction.toMap());
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
}
