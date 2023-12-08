// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sqlite3/sqlite3.dart';

import '../table.dart';

class Cluster extends DBTable {
  int? id;
  String description;
  Cluster({
    this.id,
    required this.description,
  });

  factory Cluster.fromMap(Map<String, dynamic> map) {
    return Cluster(
      id: map['id'] as int?,
      description: map['description'] as String,
    );
  }
  factory Cluster.getById(Database db, int clusterId) {
    Map<String, dynamic> map =
        db.select('SELECT * FROM Cluster WHERE id = ?', [clusterId]).first;
    return Cluster.fromMap(map);
  }

  static List<Cluster> getAll(Database db) {
    final res = db.select('SELECT * FROM Cluster');
    List<Cluster> clusters = [];
    for (var r in res) {
      clusters.add(Cluster.fromMap(r));
    }
    return clusters;
  }

  // Cluster table methods
  @override
  int upsert(Database db) {
    if (id != null) {
      db.execute('UPDATE Cluster SET description = ?, WHERE id = ?',
          [description, id!]);
    } else {
      db.execute('INSERT INTO Cluster (description) VALUES (?)', [description]);
    }
    return db.lastInsertRowId;
  }

  @override
  void delete(Database db) {
    if (id == null) return;
    db.execute('DELETE FROM Item WHERE cluster_id = ?', [id!]);
    db.execute('DELETE FROM TagCluster WHERE cluster_id = ?', [id!]);
    db.execute('DELETE FROM Cluster WHERE id = ?', [id!]);
  }

  static List<Cluster> getClustersForTag(Database db, int tagId) {
    List<Map<String, dynamic>> maps = db.select('''
      SELECT Cluster.* FROM Cluster
      JOIN TagCluster ON Cluster.id = TagCluster.cluster_id
      WHERE TagCluster.tag_id = ?
    ''', [tagId]);
    return maps.map((e) => Cluster.fromMap(e)).toList();
  }

  static void addTagToCluster(Database db, int tagId, int clusterId) {
    db.execute('INSERT INTO TagCluster (tag_id, cluster_id) VALUES (?, ?)',
        [tagId, clusterId]);
  }

  @override
  String toString() => 'Cluster(id: $id, description: $description)';

  @override
  bool operator ==(covariant Cluster other) {
    if (identical(this, other)) return true;

    return other.id == id && other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ description.hashCode;

  Cluster copyWith({
    int? id,
    String? description,
  }) {
    return Cluster(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }
}
