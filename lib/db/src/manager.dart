import 'package:sqlite3/sqlite3.dart';

class DatabaseManager {
  late Database db;

  DatabaseManager({String? path, Function()? sqlite3LibOverrider}) {
    sqlite3LibOverrider?.call();
    db = switch (path) {
      null => sqlite3.openInMemory(),
      _ => sqlite3.open(path)
    };

    _createTables();
  }

  void _createTables() {
    db.execute('''
      CREATE TABLE IF NOT EXISTS Tags (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        label TEXT,
        description TEXT
      )
    ''');

    db.execute('''
      CREATE TABLE IF NOT EXISTS Cluster (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT,
        text TEXT
      )
    ''');

    db.execute('''
      CREATE TABLE IF NOT EXISTS Item (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        path TEXT,
        ref TEXT,
        cluster_id INTEGER,
        FOREIGN KEY (cluster_id) REFERENCES Cluster(id)
      )
    ''');

    db.execute('''
      CREATE TABLE IF NOT EXISTS TagCluster (
        tag_id INTEGER,
        cluster_id INTEGER,
        FOREIGN KEY (tag_id) REFERENCES Tags(id),
        FOREIGN KEY (cluster_id) REFERENCES Cluster(id),
        PRIMARY KEY (tag_id, cluster_id)
      )
    ''');
  }

  // Close the database connection
  void close() {
    db.dispose();
  }
}
