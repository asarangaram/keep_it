import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/image_provider.dart';

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
        data: (image) => CLFullscreenBoxType2(
                child: CLImageViewer(
              image: image,
            )),
        loading: () => const LoadingView(),
        error: (err, _) => ErrorView(errorMessage: err.toString()));
  }
}
