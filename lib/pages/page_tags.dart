import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../providers/db_store.dart';
import 'views/error_view.dart';
import 'views/loading_view.dart';
import 'views/tags_view.dart';

class TagsPage extends ConsumerWidget {
  const TagsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagsAsync = ref.watch(tagsProvider(null));

    return tagsAsync.when(
      loading: () => const LoadingView(
        title: 'Read and Learn',
      ),
      error: (err, _) => ErrorView(
        errorMessage: err.toString(),
      ),
      data: (List<Tag> tags) => TagsView(tags: tags),
    );
  }
}
