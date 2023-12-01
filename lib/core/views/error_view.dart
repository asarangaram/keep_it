import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    this.errorMessage,
    Key? key,
  }) : super(key: key);
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return CLFullscreenBoxType1(
      child: CLShowError(errorMessage: errorMessage),
    );
  }
}
