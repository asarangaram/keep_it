import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
    this.title,
    this.message,
  }) : super(key: key);
  final String? title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return CLFullscreenBoxType1(child: CLLoading(message: message));
  }
}
