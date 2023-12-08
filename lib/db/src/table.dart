import 'package:sqlite3/sqlite3.dart';

abstract class DBTable {
  int upsert(Database db);

  void delete(Database db);

  /// Implement  as
  /// factory DBTable.getById(Database db, int itemId);
  /// List<DBTable> get(Database db);
}
