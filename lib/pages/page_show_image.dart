import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/image_provider.dart';
import 'views/error_view.dart';
import 'views/image_view.dart';
import 'views/loading_view.dart';

class PageShowImage extends ConsumerWidget {
  const PageShowImage({
    super.key,
    required this.imagePath,
  });
  final String imagePath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageAsync = ref.watch(imageProvider(imagePath));
    return imageAsync.when(
        data: (ui.Image image) => ImageView(
              image: image,
            ),
        loading: () => const LoadingView(),
        error: (err, _) => ErrorView(errorMessage: err.toString()));
  }
}
