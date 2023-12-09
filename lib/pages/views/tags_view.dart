import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants.dart';
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Some text",
              style: TextStyle(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: AspectRatio(
                aspectRatio: Constants.aspectRatio,
                child: const MyPageView(),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({super.key, required this.pageID});
  final int pageID;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: MyGrid(),
    );
  }
}

class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

  @override
  MyPageViewState createState() => MyPageViewState();
}

class MyPageViewState extends State<MyPageView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: 3,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double value = 1.0;
            if (_pageController.position.haveDimensions) {
              value = _pageController.page! - index;
              value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
            }
            return Center(
              child: child,
            );
          },
          child: MyPage(pageID: _currentPage), // Replace with your widgets
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
