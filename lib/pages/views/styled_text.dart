import 'package:flutter/material.dart';

enum TextTypes {
  veryLarge,
  large,
  medium,
  small,
  verySmall,
  tiny,
  links;

  double? get fontSize => switch (this) {
        TextTypes.veryLarge => 32,
        TextTypes.large => 28,
        TextTypes.medium => 24,
        TextTypes.small => 20,
        TextTypes.verySmall => 16,
        TextTypes.tiny => 12,
        TextTypes.links => null,
      };
}

class CLText extends StatelessWidget {
  const CLText.veryLarge(this.text, {super.key}) : type = TextTypes.veryLarge;

  const CLText.large(this.text, {super.key}) : type = TextTypes.large;

  const CLText.medium(this.text, {super.key}) : type = TextTypes.medium;
  const CLText.small(this.text, {super.key}) : type = TextTypes.small;
  const CLText.verySmall(this.text, {super.key}) : type = TextTypes.verySmall;
  const CLText.tiny(this.text, {super.key}) : type = TextTypes.tiny;

  final String text;
  final TextTypes type;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(fontSize: type.fontSize),
    );
  }
}
