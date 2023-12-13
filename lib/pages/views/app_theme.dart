import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppTheme extends ConsumerWidget {
  const AppTheme({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTextStyle.merge(
        style: Theme.of(context).textTheme.bodyLarge, child: child);
  }
}
