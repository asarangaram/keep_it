import 'dart:ui' as ui;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;

import '../models/image_extension.dart';

final uiImageProvider =
    FutureProvider.family.autoDispose<ui.Image?, img.Image?>(
  (ref, imgImage) async => await imgImage?.toUiImage(),
);
