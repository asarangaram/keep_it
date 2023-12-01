import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({
    super.key,
    required this.image,
  });
  final CLImage image;

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  bool fullscreen = true;
  @override
  Widget build(BuildContext context) {
    bool useSafeArea = false;
    return SafeArea(
      top: useSafeArea,
      bottom: useSafeArea,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () => setState(() {
            fullscreen = !fullscreen;
          }),
          child: ClipRect(
            clipBehavior: Clip.antiAlias,
            child: SizedBox.fromSize(
              size: size(context, useSafeArea),
              child: fullscreen
                  ? ImageViewerFullScreen(
                      image: widget.image,
                    )
                  : Center(
                      child: RawImage(
                        image: widget.image.data,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  static Size size(context, useSafeArea) {
    if (!useSafeArea) {
      return Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height);
    }
    var availableWidth = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
    var availableHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    return Size(availableWidth, availableHeight);
  }
}

class ImageViewerFullScreen extends StatelessWidget {
  const ImageViewerFullScreen({
    super.key,
    required this.image,
  });
  final CLImage image;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) => CLScrollable(
          childHeight: image.height,
          childWidth: image.width,
          child: SizedBox.expand(
            child: FittedBox(
              child: RawImage(
                image: image.data,
              ),
            ),
          ))),
    );
  }
}
