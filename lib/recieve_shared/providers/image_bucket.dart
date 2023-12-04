// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_handler/share_handler.dart';

import 'boottime_shared_images.dart';

class SharedMediaNotifier extends StateNotifier<List<SharedMedia>> {
  late final StreamSubscription? intentDataStreamSubscription;
  SharedMediaNotifier(SharedMedia? initialSharedMedia)
      : super(initialSharedMedia != null ? [initialSharedMedia] : []) {
    final handler = ShareHandler.instance;
    intentDataStreamSubscription = handler.sharedMediaStream.listen(listen);
  }
  @override
  void dispose() {
    intentDataStreamSubscription?.cancel();
    super.dispose();
  }

  Future<void> listen(SharedMedia sharedMediaFiles) async {
    //print("received an image ${sharedMediaFiles[0].path}");
    state = [sharedMediaFiles, ...state];
  }

  void pop() {
    state = List.from(state.sublist(1));
  }
}

final imageBucketProvider =
    StateNotifierProvider<SharedMediaNotifier, List<SharedMedia>>((ref) {
  return ref.watch(boottimeSharedImagesProvider).maybeWhen(
        orElse: () => SharedMediaNotifier(null),
        data: SharedMediaNotifier.new,
      );
});
