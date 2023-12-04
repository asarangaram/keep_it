import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

extension UIImage on img.Image {
  Future<ui.Image> toUiImage() async {
    final buffer = await ui.ImmutableBuffer.fromUint8List(
      getBytes(),
    );
    final id = ui.ImageDescriptor.raw(
      buffer,
      height: height,
      width: width,
      pixelFormat: ui.PixelFormat.rgba8888,
    );
    final codec =
        await id.instantiateCodec(targetHeight: height, targetWidth: width);
    final fi = await codec.getNextFrame();
    final uiImage = fi.image;
    return uiImage;
  }
}
