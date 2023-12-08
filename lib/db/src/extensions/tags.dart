import 'package:sqlite3/sqlite3.dart';

import '../../../models/models.dart';

extension TagDB on Tag {
  static getById(Database db, int tagId) {
    final map = db.select('SELECT * FROM Tags WHERE id = ?', [tagId]).first;
    return Tag.fromMap(map);
  }

  static List<Tag> getAll(Database db) {
    List<Map<String, dynamic>> maps = db.select('SELECT * FROM Tags');
    return maps.map((e) => Tag.fromMap(e)).toList();
  }

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
}
