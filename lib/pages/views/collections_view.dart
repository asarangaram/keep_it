import 'dart:math';

import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';

import '../../models/collection.dart';
import '../../models/collections.dart';

import '../../providers/db_store.dart';
import 'app_theme.dart';
import 'collections_page/add_collection.dart';
import 'collections_page/add_collection_form.dart';
import 'collections_page/main_header.dart';

class CollectionsView2 extends ConsumerStatefulWidget {
  const CollectionsView2({super.key, required this.collections});

  final Collections collections;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectionsView2State();
}

class _CollectionsView2State extends ConsumerState<CollectionsView2> {
  final GlobalKey quickMenuScopeKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CLFullscreenBox(
      isSafeArea: true,
      child: CLQuickMenuScope(
        key: quickMenuScopeKey,
        child: AppTheme(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MainHeader(quickMenuScopeKey: quickMenuScopeKey),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: CLText.large(
                            "Your Collections",
                            color: Colors.black,
                          ),
                        ),
                        Flexible(
                          child: AspectRatio(
                              aspectRatio: Constants.aspectRatio,
                              child: Column(
                                children: [
                                  if (widget.collections.isEmpty)
                                    const Center(
                                      child: CLText.small(
                                          "No collections found",
                                          color: Colors.black),
                                    )
                                  else
                                    Expanded(
                                      child: CLPageView(
                                        pageBuilder: (BuildContext context,
                                            int pageNum) {
                                          return Align(
                                            alignment: Alignment.topLeft,
                                            child: CollectionGrid(
                                              collectionsPage: widget
                                                  .collections
                                                  .page(pageNum),
                                            ),
                                          );
                                        },
                                        pageMax: widget.collections.pageMax,
                                      ),
                                    )
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ]),
                ),
              ),
              AddNewCollection(quickMenuScopeKey: quickMenuScopeKey)
            ],
          ),
        ),
      ),
    );
  }
}

class CollectionGrid extends ConsumerWidget {
  const CollectionGrid({
    super.key,
    required this.collectionsPage,
  });
  final List<Collection> collectionsPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectionsAsync = ref.read(collectionsProvider(null));
    return GridView.count(
      crossAxisCount: 4,
      padding: EdgeInsets.zero,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      shrinkWrap: true,
      childAspectRatio: Constants.aspectRatio,
      physics: const NeverScrollableScrollPhysics(),
      children: collectionsPage
          .map((Collection e) => GestureDetector(
                onLongPress: collectionsAsync.whenOrNull(
                    data: (collections) => () => showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return UpsertCollectionForm(
                              collections: collections,
                              collection: e,
                            );
                          },
                        )),
                child: CLRoundIconLabeled(
                  label: e.label,
                ),
              ))
          .toList(),
    );
  }
}

class CLRoundIconLabeled extends StatelessWidget {
  const CLRoundIconLabeled({
    super.key,
    this.label,
    this.child,
    this.horizontalSpacing = 0,
    this.verticalSpacing = 0,
  });

  final String? label;
  final Widget? child;
  final double horizontalSpacing;
  final double verticalSpacing;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: (label != null) ? Constants.aspectRatio : 1.0,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalSpacing, vertical: verticalSpacing),
        child: SizedBox.expand(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: child),
                  ),
                ),
              ),
              if (label != null)
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      label!,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
