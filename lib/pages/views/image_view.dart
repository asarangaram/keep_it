import 'dart:ui' as ui;
import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/image_provider.dart';

import 'error_view.dart';
import 'loading_view.dart';

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
        data: (image) =>  ImageView(image: image,),
        loading: () => const LoadingView(),
        error: (err, _) => ErrorView(errorMessage: err.toString()));
  }
}

class ImageView extends StatelessWidget {
  const ImageView({super.key, required this.image});
  final ui.Image image;
  @override
  Widget build(BuildContext context) {
    return CLFullscreenBoxType2(
        child: CLImageViewer(
      image: image,
    ));
  }
}
