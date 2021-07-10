class DbScripts {
  static const initScripts = [
    '''
      CREATE TABLE transactions (
        txnId INTEGER PRIMARY KEY AUTOINCREMENT, 
        txnDate TEXT NOT NULL DEFAULT  CURRENT_TIMESTAMP,
        description TEXT NOT NULL,
        amount REAL NOT NULL,
        type INTEGER NOT NULL,
        fromAccount INTEGER NOT NULL REFERENCES accounts(accountId) DEFAULT 0,
        toAccount INTEGER NOT NULL REFERENCES accounts(accountId) DEFAULT 0
      )
    ''',
    '''
      CREATE TABLE accounts (
        accountId INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT NOT NULL,
        type INTEGER NOT NULL,
        description TEXT NOT NULL DEFAULT ''
      )       
    ''',
    // 'PRAGMA foreign_keys = 0',
    // '''ALTER TABLE transactions ADD COLUMN fromAccount INTEGER NOT NULL
    //   REFERENCES accounts(accountId) DEFAULT 0''',
    // '''ALTER TABLE transactions ADD COLUMN toAccount INTEGER NOT NULL
    //   REFERENCES accounts(accountId) DEFAULT 0''',
    // 'PRAGMA foreign_keys = 1',
    '''INSERT INTO accounts (name, type, description)
        VALUES ('Balance',0,'Brought/Carry Forward')''',
    '''INSERT INTO accounts (name, type, description)
        VALUES ('Cash',1,'Cash in Hand')''',
    '''INSERT INTO accounts (name, type)
        VALUES ('Misc. Income',3)''',
    '''INSERT INTO accounts (name, type)
        VALUES ('Misc. Expense',4)''',
    '''INSERT INTO transactions 
        (description, amount, type, fromAccount, ToAccount)
        VALUES ('Initial Cash Balance', 0, 0, 1, 2)'''
  ];

  static const finalScripts = [
    initScripts,
  ];
}
