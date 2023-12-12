/* import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/pop_menu_control.dart';

class PopupMenu extends ConsumerWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final control = ref.watch(popMenuControlNotifierProvider);

    if (!control.isMenuShowing) return Container();

    final menuItems = [
      CLMenuItem('Paste', Icons.content_paste, onTap: () => print("paste")),
      CLMenuItem('Settings', Icons.content_paste,
          onTap: () => print("settings")),
      CLMenuItem('Settings', Icons.content_paste,
          onTap: () => print("settings")),
      CLMenuItem('Settings', Icons.content_paste,
          onTap: () => print("settings")),
      CLMenuItem('Settings', Icons.content_paste,
          onTap: () => print("settings")),
      CLMenuItem('Settings', Icons.content_paste,
          onTap: () => print("settings")),
      CLMenuItem('Settings', Icons.content_paste,
          onTap: () => print("settings")),
    ];
    if (!control.isMenuShowing) {
      return Container();
    }
    print("${control.region}, ${control.anchorOffset}, ${control.anchorSize}");
    return CLShowPopup(
      region: control.region,
      anchorOffset: control.anchorOffset!,
      anchorSize: control.anchorSize!,
      children: [
        ...menuItems.map((item) => CLPopupMenuItem(menuItem: item)).toList()
      ],
      // ,
      onHideMenu: () =>
          ref.read(popMenuControlNotifierProvider.notifier).hideMenu(),
    );
  }
}
 */