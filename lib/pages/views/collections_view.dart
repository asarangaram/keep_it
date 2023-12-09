import 'dart:math';

import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

import '../../models/collections.dart';

class CollectionsView2 extends StatelessWidget {
  const CollectionsView2({
    super.key,
    required this.collections,
  });
  final Collections collections;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (collections.isNotEmpty)
          const Text("TODO,", style: TextStyle(color: Colors.white)),
        Padding(
          padding: const EdgeInsets.all(8),
          child: AspectRatio(
            aspectRatio: Constants.aspectRatio,
            child: collections.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("No collections found",
                            style: TextStyle(color: Colors.white)),
                        CLStandardButton(
                          label: Text("Restore Default Collections",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  )),
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text("Or", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  )
                : CLPageView(
                    pageMax: collections.pageMax,
                    pageBuilder: (
                      context,
                      pageNum,
                    ) {
                      return MyPage(
                        collections: collections,
                        pageNum: pageNum,
                      );
                    }),
          ),
        ),
        const Spacer()
      ],
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

class MyGrid extends StatelessWidget {
  const MyGrid({super.key});

  @override
  Widget build(BuildContext context) {
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
    required this.label,
    this.child,
    this.horizontalSpacing = 8.0,
    this.verticalSpacing = 16.0,
  });

  final String label;
  final Widget? child;
  final double horizontalSpacing;
  final double verticalSpacing;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: Constants.aspectRatio,
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
                    child: child ??
                        child ??
                        DecoratedBox(
                            decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                        )),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    label,
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
