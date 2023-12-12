import 'dart:math';

import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keep_it/pages/views/styled_text.dart';

import '../../constants.dart';

import '../../models/collections.dart';

import '../../providers/theme.dart';

class CollectionsView2 extends ConsumerStatefulWidget {
  const CollectionsView2({super.key, required this.collections});

  final Collections collections;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectionsView2State();
}

class _CollectionsView2State extends ConsumerState<CollectionsView2> {
  final GlobalKey quickMenuScopeKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final customTheme = ref.watch(customThemeDataProvider);

    return CLFullscreenBoxType3(
      child: CLQuickMenuScope(
        key: quickMenuScopeKey,
        menuItems: [
          CLQuickMenuItem('Paste', Icons.content_paste,
              onTap: () => debugPrint("paste")),
          CLQuickMenuItem('Settings', Icons.settings,
              onTap: () => debugPrint("settings")),
        ],
        child: Theme(
          data: customTheme.themeData,
          child: DefaultTextStyle.merge(
            style: Theme.of(context).textTheme.bodyLarge,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Center(
                              child: CLText.veryLarge("Collections"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: CLQuickMenuAnchor(
                              parentKey: quickMenuScopeKey,
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: AspectRatio(
                          aspectRatio: Constants.aspectRatio,
                          child: Center(
                            child: Text("No collections found",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white)),
                          )),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Icon(
                      Icons.add_circle_outline_outlined,
                      color: Colors.white,
                      size: 60,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: CLText.large("Recent"),
                    ),
                    Flexible(
                      child: AspectRatio(
                          aspectRatio: Constants.aspectRatio,
                          child: Center(
                            child: Text("No collections found",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white)),
                          )),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({
    super.key,
    required this.collections,
    required this.pageNum,
  });
  final Collections collections;
  final int pageNum;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: MyGrid(),
    );
  }
}

class MyGrid extends ConsumerWidget {
  const MyGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          for (var c = 0; c < 4; c++)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                for (var r = 0; r < 4; r++)
                  Expanded(
                    child: CLRoundIconLabeled(
                        label: r == 1 ? "tiny" : "12345678901234567890 "),
                  ),
              ],
            )
        ]);
  }
}

class CLRoundIconLabeled extends StatelessWidget {
  const CLRoundIconLabeled({
    super.key,
    this.label,
    this.child,
    this.horizontalSpacing = 0,
    this.verticalSpacing = 0,
  });

  final String? label;
  final Widget? child;
  final double horizontalSpacing;
  final double verticalSpacing;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: (label != null) ? Constants.aspectRatio : 1.0,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalSpacing, vertical: verticalSpacing),
        child: SizedBox.expand(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: child != null
                              ? Theme.of(context).colorScheme.primary
                              : Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)],
                        ),
                        child: child),
                  ),
                ),
              ),
              if (label != null)
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      label!,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .labelLarge!
                          .copyWith(
                              color: Colors.white, fontFamily: 'SF Pro Text'),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, size.height / 2) // starting point at the left middle
      ..lineTo(size.width, size.height / 2) // straight line to the right middle
      ..arcToPoint(
        const Offset(0, 0),
        radius: Radius.circular(size.height / 2),
        clockwise: false,
      ) // upper-left curve
      ..arcToPoint(
        Offset(size.width, size.height),
        radius: Radius.circular(size.height / 2),
        clockwise: false,
      ); // lower-right curve

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
