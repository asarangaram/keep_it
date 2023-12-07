// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:keep_it/data/db.dart';
import 'package:keep_it/data/models/media.dart';

void main() {
  test('Test sqliteModel', () {
    // Call the function
    String result = DBTest.dbTest1();

    // Define the expected value
    String expected = DBTest.dBResult1;

    // Compare the actual result with the expected value
    expect(result, expected);
  });
}

class DBTest {
  static String dBResult1 =
      "Media(id: 2, path: /my/path/2, ref: null),Media(id: 3, path: /my/path/3, ref: https://my.url)";
  static String dbTest1() {
    DBManager dbManager = DBManager();

    final DBTable mediaTable = dbManager.insertTable(
      name: Media.tableName,
      columns: Media.tableColumns,
    );
    List<Media> newMedia = [
      Media(path: "/my/path/1"),
      Media(path: "/my/path/2"),
      Media(path: "/my/path/3", ref: "https://my.url"),
    ];

    newMedia.map((e) => mediaTable.upsert(e)).toList();

    mediaTable.deleteByID(1);

    final dbAll =
        mediaTable.load().map((e) => Media.fromMap(e).toString()).join(',');

    dbManager.dispose();

    return dbAll;
  }
}
