import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddCollection extends ConsumerWidget {
  final String label;
  final IconData iconData;
  const AddCollection(
      {super.key, required this.label, required this.iconData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: IconButton(
              onPressed: () async {},
              icon: Icon(iconData),
            ),
          ),
          Text(label),
        ],
      ),
    );
  }
}
