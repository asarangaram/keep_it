// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sqlite3/sqlite3.dart';

import '../table.dart';

class Tag extends DBTable {
  int? id;
  String label;
  String? description;
  Tag({
    this.id,
    required this.label,
    this.description,
  });

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'] != null ? map['id'] as int : null,
      label: map['label'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }
  factory Tag.getById(Database db, int tagId) {
    final map = db.select('SELECT * FROM Tags WHERE id = ?', [tagId]).first;
    return Tag.fromMap(map);
  }

  static List<Tag> getAll(Database db) {
    List<Map<String, dynamic>> maps = db.select('SELECT * FROM Tags');
    return maps.map((e) => Tag.fromMap(e)).toList();
  }

  @override
  int upsert(Database db) {
    if (id != null) {
      db.execute('UPDATE Tags SET label = ?, description = ? WHERE id = ?',
          [label, description, id!]);
    } else {
      db.execute('INSERT INTO Tags (label, description) VALUES (?, ?)',
          [label, description]);
    }
    return db.lastInsertRowId;
  }

  @override
  void delete(Database db, {int? alternateTagId}) {
    if (id == null) return;

    if (alternateTagId != null) {
      db.execute("""
INSERT OR REPLACE INTO TagCluster (tag_id, cluster_id)
SELECT 
    CASE 
        WHEN tag_id = ? THEN ?
        ELSE tag_id
    END AS new_tag_id,
    cluster_id
FROM TagCluster
WHERE tag_id = ?
""", [id!, alternateTagId, id!]);
    } else {
      db.execute("DELETE FROM TagCluster WHERE tag_id = ?;", [id!]);
    }

    if (db.select(
        "SELECT * FROM TagCluster WHERE tag_id = ?;", [id!]).isNotEmpty) {
      throw Exception("${id!} is still used! Check implementation");
    }

    db.execute('DELETE FROM Tags WHERE id = ?', [id!]);
  }

  static List<Tag> getTagsForCluster(Database db, int clusterId) {
    final List<Map<String, dynamic>> maps = db.select('''
      SELECT Tags.* FROM Tags
      JOIN TagCluster ON Tags.id = TagCluster.tag_id
      WHERE TagCluster.cluster_id = ?
    ''', [clusterId]);
    return maps.map((e) => Tag.fromMap(e)).toList();
  }

  static List<Tag> getTagsForItem(Database db, int itemId) {
    final List<Map<String, dynamic>> maps = db.select('''
      SELECT Tags.* FROM Tags
      JOIN TagCluster ON Tags.id = TagCluster.tag_id
      JOIN Item ON TagCluster.cluster_id = Item.cluster_id
      WHERE Item.id = ?
    ''', [itemId]);
    return maps.map((e) => Tag.fromMap(e)).toList();
  }

  Tag copyWith({
    int? id,
    String? label,
    String? description,
  }) {
    return Tag(
      id: id ?? this.id,
      label: label ?? this.label,
      description: description ?? this.description,
    );
  }

  @override
  String toString() => 'Tag(id: $id, label: $label, description: $description)';

  @override
  bool operator ==(covariant Tag other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.label == label &&
      other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ label.hashCode ^ description.hashCode;
}
