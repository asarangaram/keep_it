import 'package:app_loader/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/page_show_image.dart';
import 'pages/views/shared_items_view.dart';

class KeepItApp implements AppDescriptor {
  @override
  String get title => "Keep It";

  @override
  CLAppInitializer get appInitializer => (ref) async => true;

  @override
  Map<String, CLWidgetBuilder> get screenBuilders {
    return {
      "home": (context) => const PageShowImage(
          imagePath: "assets/wallpaperflare.com_wallpaper-2.jpg"),
    };
  }

  @override
  IncomingMediaViewBuilder get incomingMediaViewBuilder =>
      (BuildContext context, WidgetRef ref,
          {required Map<String, SupportedMediaType> sharedMedia,
          required Function() onDiscard}) {
        return SharedItemsView(
          sharedMedia: sharedMedia,
          onDiscard: onDiscard,
        );
      };

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
      child: AppLoader(
    appDescriptor: KeepItApp(),
  )));
}
