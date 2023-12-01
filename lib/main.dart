import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'views/image_view.dart';

void main() {
  const String imagePath = "assets/wallpaperflare.com_wallpaper-2.jpg";
  runApp(const ProviderScope(
      child: MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ImageView(
      imagePath: imagePath,
    ),
  )));
}
