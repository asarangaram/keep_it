import 'package:flutter_riverpod/flutter_riverpod.dart';

//import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:share_handler/share_handler.dart';

final boottimeSharedImagesProvider = FutureProvider<SharedMedia?>((ref) async {
  final handler = ShareHandler.instance;
  final sharedMediaFiles = await handler.getInitialSharedMedia();
  return sharedMediaFiles;
});
