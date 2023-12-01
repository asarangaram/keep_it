import 'package:flutter/material.dart';

import '../core/views/image_view.dart';

class KeetIt extends StatelessWidget {
  const KeetIt({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String imagePath = "assets/wallpaperflare.com_wallpaper-2.jpg";
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageView(
        imagePath: imagePath,
      ),
    );
  }
}
