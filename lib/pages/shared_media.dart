import 'package:app_loader/app_loader.dart';
import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageSharedMedia extends ConsumerWidget {
  const PageSharedMedia({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaPending = ref.watch(imageBucketProvider);
    return Scaffold(
      body: Center(
        child: Text("Pending Media to Process: ${mediaPending.length}"),
      ),
    );
  }
}
