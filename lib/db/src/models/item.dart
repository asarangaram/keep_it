// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sqlite3/sqlite3.dart';

import '../table.dart';

class Item extends DBTable {
  int? id;
  String path;
  String? ref;
  int clusterId;
  Item({
    this.id,
    required this.path,
    this.ref,
    required this.clusterId,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int?,
      path: map['path'] as String,
      ref: map['ref'] as String?,
      clusterId: map['cluster_id'] as int,
    );
  }

  factory Item.getById(Database db, int itemId) {
    final Map<String, dynamic> map =
        db.select('SELECT * FROM Item WHERE id = ?', [itemId]).first;
    return Item.fromMap(map);
  }

  static List<Item> getAll(Database db) {
    List<Map<String, dynamic>> maps = db.select('SELECT * FROM Item');
    return maps.map((e) => Item.fromMap(e)).toList();
  }

  @override
  int upsert(
    Database db,
  ) {
    if (id != null) {
      db.execute(
          'UPDATE Item SET path = ?, ref = ?, cluster_id = ? WHERE id = ?',
          [path, ref, clusterId, id!]);
    }
    db.execute('INSERT INTO Item (path, ref, cluster_id) VALUES (?, ?, ?)',
        [path, ref, clusterId]);
    return db.lastInsertRowId;
  }

  @override
  void delete(Database db) {
    if (id == null) return;
    db.execute('DELETE FROM Item WHERE id = ?', [id!]);
  }

  static List<Item> getItemsForCluster(Database db, int clusterId) {
    List<Map<String, dynamic>> maps =
        db.select('SELECT * FROM Item WHERE cluster_id = ?', [clusterId]);

    return maps.map((e) => Item.fromMap(e)).toList();
  }

  Item copyWith({
    int? id,
    String? path,
    String? ref,
    int? clusterId,
  }) {
    return Item(
      id: id ?? this.id,
      path: path ?? this.path,
      ref: ref ?? this.ref,
      clusterId: clusterId ?? this.clusterId,
    );
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.path == path &&
        other.ref == ref &&
        other.clusterId == clusterId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ path.hashCode ^ ref.hashCode ^ clusterId.hashCode;
  }

  @override
  String toString() {
    return 'Item(id: $id, path: $path, ref: $ref, clusterId: $clusterId)';
  }
}
