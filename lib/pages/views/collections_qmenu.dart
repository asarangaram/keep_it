import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/theme.dart';

class CollectionsQMenu extends ConsumerWidget {
  const CollectionsQMenu({super.key});

  List<CLQuickMenuItem> get menuItems => [
        CLQuickMenuItem('Paste', Icons.content_paste,
            onTap: () => debugPrint("paste")),
        CLQuickMenuItem('Settings', Icons.settings,
            onTap: () => debugPrint("settings")),
      ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double menuItemWidth = kMinInteractiveDimension * 1.5;
    final customTheme = ref.watch(customThemeDataProvider);
    return Theme(
      data: customTheme.themeData,
      child: DefaultTextStyle.merge(
        style: Theme.of(context).textTheme.bodyLarge,
        child: Container(
          width: menuItemWidth * (menuItems.length > 4 ? 4 : menuItems.length),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          child: GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: menuItems.length > 4 ? 4 : menuItems.length,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            shrinkWrap: true,
            childAspectRatio: 1.0,
            physics: const NeverScrollableScrollPhysics(),
            children: menuItems
                .map(
                  (e) => Container(
                    alignment: Alignment.center,
                    // decoration: const BoxDecoration(color: Colors.white),
                    padding: const EdgeInsets.all(4),
                    width: menuItemWidth,
                    child: CLIconButton.labelled(
                      e.icon,
                      scaleType: ScaleType.tiny,
                      label: e.title,
                      onTap: e.onTap,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

/**
 * 
 *  decoration: backgroundDecoration,
      width: menuItemWidth *
          (children.length > 4 ? 4 : children.length).toDouble(),
 */
