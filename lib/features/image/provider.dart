// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageNotifier extends StateNotifier<AsyncValue<CLImage>> {
  String imagePath;
  ImageNotifier(this.imagePath) : super(const AsyncValue.loading()) {
    _get();
  }

  Future<void> _get() async {
    state = await AsyncValue.guard(() async {
      try {
        final data = await rootBundle.load(imagePath);
        final decodedImage = img.decodeImage(data.buffer.asUint8List());
        final width = decodedImage?.width.toDouble();
        final height = decodedImage?.height.toDouble();
        ui.Codec codec =
            await ui.instantiateImageCodec(data.buffer.asUint8List());
        ui.FrameInfo fi = await codec.getNextFrame();
        ui.Image uiImage = fi.image;

        return CLImage(
            data: uiImage,
            width: width ?? uiImage.width.toDouble(),
            height: height ?? uiImage.width.toDouble());
      } catch (err) {
        throw Exception("Failed to load Image");
      }
    });
  }
}

final imageProvider =
    StateNotifierProvider.family<ImageNotifier, AsyncValue<CLImage>, String>(
        (ref, imagePath) {
  return ImageNotifier(imagePath);
});
