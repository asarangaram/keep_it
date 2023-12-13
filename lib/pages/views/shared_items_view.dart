import 'package:app_loader/app_loader.dart';
import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../db/db.dart';
import '../../providers/db_manager.dart';

import 'error_view.dart';
import 'loading_view.dart';

class SharedItemsView extends ConsumerWidget {
  const SharedItemsView({
    super.key,
    required this.media,
    required this.onDiscard,
  });

  final Map<String, SupportedMediaType> media;
  final Function() onDiscard;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageAsync = ref.watch(dbManagerProvider);
    return imageAsync.when(
        data: (DatabaseManager dbManager) => SharedItemsViewInternal(
              media: media,
              onDiscard: onDiscard,
              dbManager: dbManager,
            ),
        loading: () => const LoadingView(),
        error: (err, _) => ErrorView(errorMessage: err.toString()));
  }
}

class SharedItemsViewInternal extends ConsumerWidget {
  const SharedItemsViewInternal({
    super.key,
    required this.media,
    required this.onDiscard,
    required this.dbManager,
  });

  final Map<String, SupportedMediaType> media;
  final Function() onDiscard;
  final DatabaseManager dbManager;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CLFullscreenBoxType1(
      safeArea: true,
      child: Stack(
        children: [
          Center(
              child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              for (final e in media.entries) ...[
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "${e.value.name.toUpperCase()}: ",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: e.key)
                ])),
                const SizedBox(height: 16),
              ],
              CLStandardButton(
                  label: const CLText.medium("Save"),
                  onPressed: () {
                    // TODO: Implement
                    //onDiscard();
                  })
            ]),
          )),
          Positioned(
              top: 16,
              right: 16,
              child: CLStandardButton.icon(
                icon: const Icon(Icons.close),
                onPressed: onDiscard,
              ))
        ],
      ),
    );
  }
}
