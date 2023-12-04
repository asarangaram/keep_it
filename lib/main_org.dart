import 'package:app_loader/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_handler/share_handler.dart';

import 'pages/page_show_image.dart';

class KeepItApp implements AppDescriptor {
  @override
  String get title => "Keep It";

  @override
  CLAppInitializer get appInitializer => (ref) async => true;

  @override
  Map<String, CLWidgetBuilder> get screenBuilders {
    return {
      "home": (context) => const PageShowImage(
          imagePath: "assets/wallpaperflare.com_wallpaper-2.jpg")
    };
  }

  @override
  CLTransitionBuilder get transitionBuilder => (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: Offset.zero)
              .animate(animation),
          child: child,
        );
      };

  @override
  CLRedirector get redirector => (String location) async {
        if (location == "/") return "/home";
        return null;
      };
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /* SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ); */
  return runApp(ProviderScope(
      child: ShareHandlerView(
    child: AppLoader(
      appDescriptor: KeepItApp(),
    ),
  )));
}

class ShareHandlerView extends ConsumerStatefulWidget {
  const ShareHandlerView({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ShareHandlerViewState();
}

class ShareHandlerViewState extends ConsumerState<ShareHandlerView> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  SharedMedia? media;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    final handler = ShareHandler.instance;
    media = await handler.getInitialSharedMedia();

    handler.sharedMediaStream.listen((SharedMedia media) {
      if (!mounted) return;
      setState(() {
        this.media = media;
      });
    });
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
