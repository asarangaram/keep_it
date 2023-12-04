import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'image_bucket.dart';

final watchSharedImage = Provider<bool>((ref) {
  final imageBucket = ref.watch(imageBucketProvider);
  return imageBucket.isNotEmpty;
});
