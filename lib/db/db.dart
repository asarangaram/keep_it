// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:sqlite3/sqlite3.dart';

export 'src/extensions/cluster.dart';
export 'src/extensions/item.dart';
export 'src/extensions/tags.dart';

class TagsUpdatedEvent {
  String msg;
  TagsUpdatedEvent({
    required this.msg,
  });
}

class DatabaseManager {
  final _controller = StreamController<TagsUpdatedEvent>.broadcast();
  Stream<void> get onDataChanged => _controller.stream;
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
    db.createFunction(
      functionName: 'tags_updated',
      function: onTagsUpdated,
      argumentCount: const AllowedArgumentCount(2),
      deterministic: true,
      directOnly: false,
    );
    db.execute('CREATE TRIGGER IF NOT EXISTS tag_inserted '
        'AFTER INSERT ON Tags BEGIN '
        'SELECT tags_updated("inserted", NEW.id); '
        'END');
    db.execute('CREATE TRIGGER IF NOT EXISTS tag_updated '
        'AFTER UPDATE ON Tags BEGIN '
        'SELECT tags_updated("updated", NEW.id); '
        'END');
    db.execute('CREATE TRIGGER IF NOT EXISTS tag_deleted '
        'AFTER DELETE ON Tags BEGIN '
        'SELECT tags_updated("deleted", OLD.id); '
        'END');
  }

  void onTagsUpdated(List<Object?> arguments) {
    _controller.add(TagsUpdatedEvent(msg: arguments[0] as String));
    return;
  }

  // Close the database connection
  void close() {
    _controller.close();
    db.dispose();
  }

  StreamSubscription<TagsUpdatedEvent> registerListener(
      Function(TagsUpdatedEvent event) listener) {
    return _controller.stream.listen(listener);
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

