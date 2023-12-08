import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

class TagsView extends StatefulWidget {
  const TagsView({
    super.key,
    required this.tags,
  });
  final List<Tag> tags;
  @override
  State<StatefulWidget> createState() => _TagsViewState();
}

class _TagsViewState extends State<TagsView> {
  @override
  Widget build(BuildContext context) {
    return const CLFullscreenBoxType1(
      child: Text("Hello World"),
    );
  }
}
