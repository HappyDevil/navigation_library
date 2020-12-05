import 'package:flutter/widgets.dart';

import 'base_state.dart';

abstract class BasePage<T extends NavigationBaseState> extends Page {
  final T state;

  BasePage(this.state) : super(key: ValueKey(state));
}
