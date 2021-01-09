import 'package:flutter/widgets.dart';

import '../model/base_state.dart';

abstract class BasePage<T extends NavigationBaseState> extends Page<dynamic> {
  BasePage(this.state, {bool generateKey = true}) : super(key: (generateKey) ? ValueKey(state) : null);

  final T state;
}
