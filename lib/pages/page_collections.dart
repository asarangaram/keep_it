import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/db_store.dart';
import 'views/error_view.dart';
import 'views/loading_view.dart';
import 'views/collections_view.dart';

class CollectionsPage extends ConsumerWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectionsAsync = ref.watch(collectionsProvider(null));

    return collectionsAsync.when(
      loading: () => const LoadingView(
        title: 'Read and Learn',
      ),
      error: (err, _) => ErrorView(
        errorMessage: err.toString(),
      ),
      data: (collections) => CLFullscreenBoxType3(
          child: CollectionsView2(collections: collections)),
    );
  }
}
