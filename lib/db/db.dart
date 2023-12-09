import 'package:sqlite3/sqlite3.dart';

export 'src/extensions/cluster.dart';
export 'src/extensions/item.dart';
export 'src/extensions/tags.dart';

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
        label TEXT NOT NULL UNIQUE,
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
        path TEXT NOT NULL UNIQUE,
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
/*

class DataNotifier {
  // Create a stream controller
  
  // Create a stream for listening to changes
  
  // Function to trigger a data change
  void notifyDataChanged() {
    
  }

  // Close the stream controller when no longer needed
  void dispose() {
    
  }
}
*/

