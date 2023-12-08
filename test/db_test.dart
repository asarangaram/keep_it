import 'package:flutter_test/flutter_test.dart';
import 'package:keep_it/db/db.dart';

void main() {
  test('test database', () {
    // Compare the actual result with the expected value
    expect(DBTest.dbTest1(), true);
  });
}

class DBTest {
  static bool dbTest1() {
    final DatabaseManager dbManager = DatabaseManager();
    var db = dbManager.db;

    final List<int> tagIds = [];
    final List<int> clusterIds = [];
    final List<int> itemIds = [];

    // Insert data
    for (var i = 0; i < 3; i++) {
      tagIds.add(
          Tag(label: 'Tag$i', description: 'Tag$i Description').upsert(db));
    }
    for (var i = 0; i < 2; i++) {
      clusterIds.add(Cluster(description: 'Cluster$i Description').upsert(db));
    }

    for (var i = 0; i < 6; i++) {
      itemIds.add(Item(
              path: '/path/to/item$i',
              ref: i == 5 ? "ref5" : null,
              clusterId: clusterIds[i & 1])
          .upsert(db));
    }

    Cluster.addTagToCluster(db, tagIds[0], clusterIds[0]);
    Cluster.addTagToCluster(db, tagIds[1], clusterIds[0]);
    Cluster.addTagToCluster(db, tagIds[1], clusterIds[1]);
    Cluster.addTagToCluster(db, tagIds[2], clusterIds[1]);

    // Retrieve data
    // TODO Write verifialbe logic.
    final tags = Tag.getAll(db);

    for (var tag in tags) {
      final clusters = Cluster.getClustersForTag(db, tag.id!);
      for (var cluster in clusters) {
        Tag.getTagsForCluster(db, cluster.id!);
        Item.getItemsForCluster(db, cluster.id!);
      }
    }

    dbManager.close();

    return true;
  }
}
