import 'package:sqlite3/sqlite3.dart';

class DBManager {
  final String? fullPath;
  final Function()? sqlite3LibOverrider;
  late final Database _database;

  DBManager({this.fullPath, this.sqlite3LibOverrider}) {
    try {
      sqlite3LibOverrider?.call();
      if (fullPath == null) {
        _database = sqlite3.openInMemory();
        return;
      }
      _database = sqlite3.open(fullPath!);
    } catch (e) {
      throw Exception("Failed to open DB");
    }
  }

  DBTable insertTable({
    required name,
    required String columns,
  }) =>
      DBTable(db: _database, name: name, columns: columns);

  void dispose() => _database.dispose();
}

extension ListCompare on List<String> {
  bool isSameAs(List<String> list2) {
    var set1 = toSet();
    var set2 = list2.toSet();

    return set1.length == set2.length && set1.containsAll(set2);
  }
}

abstract class DBRow {
  int? id;
  DBRow({this.id});

  bool get hasId => id != null;
  Map<String, dynamic> toMap();
}

class DBTable {
  final Database db;
  final String name;
  late final Map<String, String> columns = {};
  Map<String, String> get columnsAll {
    final all = {"id": "INTEGER PRIMARY KEY AUTOINCREMENT"};

    all.addAll(columns);
    return all;
  }

  DBTable({
    required this.db,
    required this.name,
    required String columns,
  }) {
    final temp = columns.trim().split(',');

    for (var c in temp) {
      var parts = c.trim().split(' ').map((e) => e.trim()).toList();

      if (parts.length > 1) {
        this.columns[parts[0]] = parts.sublist(1).join(' ');
      }
    }
    _createTable(db);
  }

  void _createTable(Database db) {
    try {
      if (!_doesTableExist(db)) {
        List<String> ss =
            columnsAll.entries.map((e) => "${e.key} ${e.value}").toList();

        db.execute("CREATE TABLE IF NOT EXISTS $name (${ss.join(", ")})");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  bool _doesTableExist(Database db) {
    return db.select(
            "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
            [name]).isNotEmpty &&
        _doesTableHaveColumns(db);
  }

  bool _doesTableHaveColumns(Database db) {
    final validTable = columnsAll.keys.toList().isSameAs(db
        .select("PRAGMA table_info($name)")
        .map((row) => row['name'].toString())
        .toList());

    if (!validTable) {
      throw Exception("Table doesn't match the model. Check version");
    }
    return true;
  }

  static const String _requiredColumns =
      "path, aux, time, uploadStatus, progress, serverResponse, isScheduled";

  static List<String> get requiredColumns =>
      ['id', ..._requiredColumns.split(', ')];
  static String get rowOrder {
    return '($_requiredColumns) VALUES (${_requiredColumns.split(', ').map((e) => '?').join(", ")})';
  }

  int upsert(DBRow rowModel) {
    final Map<String, dynamic> map_ = rowModel.toMap();

    final String s1 = columns.keys.join(', ');
    final String s2 = columns.keys.map((e) => '?').join(', ');

    final List<dynamic> values = columns.keys.map((e) => map_[e]).toList();
    final PreparedStatement insertStmt;
    if (rowModel.hasId) {
      //update
      insertStmt = db.prepare(
          'UPDATE $name SET ($s1) VALUES ($s2) WHERE id==${rowModel.id!}');
    } else {
      // insert
      insertStmt = db.prepare('INSERT OR IGNORE INTO $name ($s1) VALUES ($s2)');
    }
    insertStmt.execute(values);
    final id = db.lastInsertRowId;
    insertStmt.dispose();
    return id;
  }

  Map<String, dynamic> loadByID(int id) {
    final wh = "WHERE id == $id";
    final ResultSet result = db.select('SELECT * FROM $name $wh;');
    assert(result.length == 1);
    Row row = result[0];

    return columnsAll.map((key, value) => MapEntry(key, row[key]));
  }

  List<Map<String, dynamic>> load() {
    final ResultSet result = db.select('SELECT * FROM $name;');
    final List<Map<String, dynamic>> items = [];
    for (var row in result) {
      items.add(columnsAll.map((key, value) => MapEntry(key, row[key])));
    }
    return items;
  }

  bool deleteByID(int id) {
    final deleteStmt = db.prepare('DELETE FROM $name  WHERE id==$id');
    deleteStmt.execute();

    deleteStmt.dispose();
    return true;
  }
}
