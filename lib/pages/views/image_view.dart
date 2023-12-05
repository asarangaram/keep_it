import 'dart:ui' as ui;
import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';

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
