import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/image/provider.dart';
import '../features/image/image_viewer.dart';
import 'error_view.dart';
import 'loading_view.dart';

class ImageView extends ConsumerWidget {
  const ImageView({
    super.key,
    required this.imagePath,
  });
  final String imagePath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageAsync = ref.watch(imageProvider(imagePath));
    return imageAsync.when(
        data: (image) => ImageViewer(image: image),
        loading: () => const LoadingView(),
        error: (err, _) => ErrorView(errorMessage: err.toString()));
  }
}
