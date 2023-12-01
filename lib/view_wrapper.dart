import 'package:flutter/material.dart';

class ViewWrapper extends StatelessWidget {
  const ViewWrapper({
    required this.title,
    required this.body,
    Key? key,
    this.scaffoldKey,
    this.centerTitle = true,
    this.floatingActionButton,
    this.drawer,
    this.actions,
    this.showBottomSheet = true,
    this.fullscreen = false,
    this.from,
  }) : super(key: key);
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final String? title;
  final bool centerTitle;
  final Widget body;
  final FloatingActionButton? floatingActionButton;
  final Widget? drawer;
  final List<Widget>? actions;
  final bool showBottomSheet;
  final bool fullscreen;
  final String? from;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        key: scaffoldKey,
        bottomSheet:
            showBottomSheet ? RnLBottomSheet(fullscreen: fullscreen) : null,
        appBar: (title != null)
            ? AppBar(
                centerTitle: centerTitle,
                title: Center(
                  child: Text(
                    title!,
                    textAlign: TextAlign.center,
                  ),
                ),
                leading: fullscreen
                    ? (from != null)
                        ? IconButton(
                            onPressed: () {/* context.pop() */},
                            icon: const Icon(Icons.close_fullscreen_sharp),
                          )
                        : null
                    : null,
                backgroundColor:
                    fullscreen ? Theme.of(context).canvasColor : null,
                elevation: fullscreen ? 0 : null,
                actions: actions,
              )
            : null,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: body,
        ),
        floatingActionButton: floatingActionButton,
        drawer: drawer,
      ),
    );
  }
}

class RnLBottomSheet extends StatelessWidget {
  const RnLBottomSheet({
    required this.fullscreen,
    Key? key,
  }) : super(key: key);
  final bool fullscreen;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: fullscreen
            ? Theme.of(context).canvasColor
            : Theme.of(context).primaryColor,
      ),
      child: const Padding(
        padding: EdgeInsets.only(bottom: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '© Read and Learn',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
