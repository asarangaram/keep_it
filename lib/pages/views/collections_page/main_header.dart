import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keep_it/utils/extensions.dart';

import '../../../providers/theme.dart';
import '../app_theme.dart';

class MainHeader extends ConsumerWidget {
  const MainHeader({
    super.key,
    required this.quickMenuScopeKey,
  });

  final GlobalKey<State<StatefulWidget>> quickMenuScopeKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customTheme = ref.watch(customThemeDataProvider);
    return Padding(
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
              menuBuilder: (context, boxconstraints) {
                return AppTheme(
                  child: CLQuickMenuGrid(
                    menuItems: [
                      CLQuickMenuItem('Paste', Icons.content_paste,
                          onTap: () => debugPrint("paste")),
                      CLQuickMenuItem('Settings', Icons.settings,
                          onTap: () => debugPrint("settings")),
                    ],
                    backgroundColor:
                        customTheme.color.invertColor().withAlpha(128),
                    foregroundColor: customTheme.color,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
