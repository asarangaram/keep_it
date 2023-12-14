import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/theme.dart';
import '../app_theme.dart';

class MainHeader extends ConsumerWidget {
  const MainHeader({
    super.key,
    required this.quickMenuScopeKey,
  });

  final GlobalKey<State<StatefulWidget>> quickMenuScopeKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: CLText.veryLarge(
                "Collections",
                color: theme.colorTheme.textColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CLQuickMenuAnchor(
              parentKey: quickMenuScopeKey,
              menuBuilder: (context, boxconstraints) {
                return AppTheme(
                  child: CLQuickMenuGrid.tiny(
                    menuItems: [
                      CLQuickMenuItem('Paste', Icons.content_paste,
                          onTap: () => debugPrint("paste")),
                      CLQuickMenuItem('Settings', Icons.settings,
                          onTap: () => debugPrint("settings")),
                    ],
                    foregroundColor: theme.colorTheme.textColor,
                    backgroundColor: theme.colorTheme.overlayBackgroundColor,
                    disabledColor: theme.colorTheme.disabledColor,
                  ),
                );
              },
              child: CLIcon.small(
                Icons.more_vert,
                color: theme.colorTheme.textColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
