import 'package:app_loader/app_loader.dart';
import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SharedItemsView extends ConsumerStatefulWidget {
  const SharedItemsView({
    super.key,
    required this.sharedMedia,
    required this.onDiscard,
  });

  final Map<String, SupportedMediaType> sharedMedia;
  final Function() onDiscard;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SharedItemsViewState();
}

class _SharedItemsViewState extends ConsumerState<SharedItemsView> {
  @override
  Widget build(BuildContext context) {
    final media = widget.sharedMedia;
    return CLFullscreenBoxType1(
      child: Center(
          child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (final e in media.entries) ...[
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "${e.value.name.toUpperCase()}: ",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: e.key)
            ])),
            const SizedBox(height: 16),
          ],
          CLStandardButton(label: "Clear", onPressed: widget.onDiscard)
        ]),
      )),
    );
  }
}
