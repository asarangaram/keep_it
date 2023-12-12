import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/theme.dart';

final customThemeDataProvider = StateProvider<CustomThemeData>((ref) {
  return CustomThemeData();
});
