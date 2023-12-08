import 'dart:io';

import 'package:app_loader/app_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/db.dart';
import '../models/models.dart';

class DBStore {
  final bool isDirty;
  DBStore({required this.isDirty});
}

class DBStoreNotifier extends StateNotifier<DBStore> {
  DBStoreNotifier() : super(DBStore(isDirty: false));

  onSaveCluster({
    required DatabaseManager dbManager,
    required Map<String, SupportedMediaType> media,
  }) async {
    final db = dbManager.db;
    // Create new Cluster

    final clusterId = Cluster(description: "No Description").upsert(db);

    for (MapEntry<String, SupportedMediaType> m in media.entries) {
      switch (m.value) {
        case SupportedMediaType.text:
        case SupportedMediaType.url:
        default:
          final path = m.key;
          final String newFile;
          final String? ref;
          if (!await File(path).exists()) {}
          newFile = await FileHandler.move(path, toDir: 'keep_it');
          if (await File("$path.url").exists()) {
            ref = await File("$path.url").readAsString();
            await File("$path.url").delete();
          } else {
            ref = null;
          }
          await File(path).delete();

          Item(path: newFile, ref: ref, clusterId: clusterId).upsert(db);
      }
    }
  }
}

final dbStoreProvider = StateNotifierProvider<DBStoreNotifier, DBStore>((ref) {
  return DBStoreNotifier();
});
