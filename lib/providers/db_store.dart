// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keep_it/db/db.dart';

import '../models/models.dart';
import 'db_manager.dart';

class TagNotifier extends StateNotifier<AsyncValue<List<Tag>>> {
  DatabaseManager? databaseManager;
  int? clusterId;

  bool isLoading = false;
  TagNotifier({
    this.databaseManager,
    this.clusterId,
  }) : super(const AsyncValue.loading()) {
    loadTags();
  }
  // Some race condition might occuur if many tags are updated
  /// How to avoid more frequent update if many triggers occur one after other.
  loadTags() async {
    if (databaseManager == null) return;
    final List<Tag> tags;

    if (clusterId == null) {
      tags = TagDB.getAll(databaseManager!.db);
    } else {
      tags = TagDB.getTagsForCluster(databaseManager!.db, clusterId!);
    }
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return tags;
    });
  }

  void upsert(List<Tag> tags) {
    if (databaseManager == null) {
      throw Exception("DB Manager is not ready");
    }
    for (var tag in tags) {
      tag.upsert(databaseManager!.db);
    }
    loadTags();
  }

  void delete(List<Tag> tags) {
    if (databaseManager == null) {
      throw Exception("DB Manager is not ready");
    }
    for (var tag in tags) {
      tag.delete(databaseManager!.db);
    }
    loadTags();
  }
}

final tagsProvider =
    StateNotifierProvider.family<TagNotifier, AsyncValue<List<Tag>>, int?>(
        (ref, clusterId) {
  final dbManagerAsync = ref.watch(dbManagerProvider);
  return dbManagerAsync.when(
    data: (DatabaseManager dbManager) =>
        TagNotifier(databaseManager: dbManager, clusterId: clusterId),
    error: (_, __) => TagNotifier(),
    loading: () => TagNotifier(),
  );
});
