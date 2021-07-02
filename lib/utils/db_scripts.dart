class DbScripts {
  static const initScripts = [
    '''
      CREATE TABLE transactions (
        txnId INTEGER PRIMARY KEY AUTOINCREMENT, 
        txnDate TEXT NOT NULL,
        description TEXT NOT NULL,
        amount REAL NOT NULL             
      )
    ''',
    '''
      CREATE TABLE accounts (
        accountId INTEGER PRIMARY KEY AUTOINCREMENT, 
        accountName TEXT NOT NULL,
        accountType INTEGER NOT NULL,
        accountDescriptiom TEXT NOT NULL
      )       
    ''',
    'PRAGMA foreign_keys = 0',
    '''ALTER TABLE transactions ADD COLUMN fromAccount INTEGER NOT NULL 
      REFERENCES accounts(accountId) DEFAULT 0''',
    '''ALTER TABLE transactions ADD COLUMN toAccount INTEGER NOT NULL 
      REFERENCES accounts(accountId) DEFAULT 0''',
    'PRAGMA foreign_keys = 1',
  ];
}
