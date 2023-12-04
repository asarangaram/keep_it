import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class ImageBucket {
  const ImageBucket({
    required this.imagePathList,
  });
  final List<String> imagePathList;

  ImageBucket copyWith({
    List<String>? images,
  }) {
    return ImageBucket(
      imagePathList: images ?? imagePathList,
    );
  }

  @override
  String toString() => 'ImageBucket(images: $imagePathList)';

  @override
  bool operator ==(covariant ImageBucket other) {
    if (identical(this, other)) {
      return true;
    }
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.imagePathList, imagePathList);
  }

  @override
  int get hashCode => imagePathList.hashCode;

  bool isEmpty() => imagePathList.isEmpty;
  bool isNotEmpty() => imagePathList.isNotEmpty;
}
