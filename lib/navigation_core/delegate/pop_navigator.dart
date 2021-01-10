import 'package:flutter/widgets.dart';
import 'package:navigation_library_impl/navigation_core/model/result_model.dart';

abstract class PopNavigator {
  bool pop({ResultModel? result});

  static PopNavigator of(final BuildContext context) => MockPopNavigator(context);
}

class MockPopNavigator implements PopNavigator {
  MockPopNavigator(final BuildContext context) : _navigatorState = Navigator.of(context);

  final NavigatorState _navigatorState;

  @override
  bool pop({ResultModel? result}) {
    if (!_navigatorState.canPop()) return false;
    _navigatorState.pop(result);
    return true;
  }
}
