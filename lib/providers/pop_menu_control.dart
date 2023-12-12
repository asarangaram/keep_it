import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/pop_menu_control.dart';

class PopMenuControlNotifier extends StateNotifier<PopMenuControl> {
  PopMenuControlNotifier() : super(PopMenuControl());
  void showMenu({
    Size? region,
    required Size anchorSize,
    required Offset anchorOffset,
  }) =>
      state = state.showMenu(
        region: region,
        anchorSize: anchorSize,
        anchorOffset: anchorOffset,
      );
  void hideMenu() => state = state.hideMenu();
  /* void editText(bool enable) => state = state.editText(enable); */
}

final popMenuControlNotifierProvider =
    StateNotifierProvider<PopMenuControlNotifier, PopMenuControl>((ref) {
  return PopMenuControlNotifier();
  //throw Exception("You must  override popMenuControlNotifierProvider to use");
});
