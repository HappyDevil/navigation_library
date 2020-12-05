import 'package:flutter/widgets.dart';

import 'base_state.dart';

abstract class BaseRouterDelegate<T extends NavigationBaseState> extends RouterDelegate<T>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<T>
    implements OpenNavigator<T> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final List<T> _cachedStates = [];

  @override
  T get currentConfiguration => _cachedStates.last;

  BaseRouterDelegate() {
    _cachedStates.add(initState());
  }

  @override
  Widget build(BuildContext context) {
    print('build $_cachedStates');
    return Navigator(
      key: navigatorKey,
      pages: _cachedStates.map(mapStateToPage).toList(),
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _cachedStates.removeLast();
        notifyListeners();

        return true;
      },
    );
  }

  T initState();
  Page mapStateToPage(T e);

  @override
  Future<void> setNewRoutePath(T path) => _pathUpdated(path);

  Future<void> _pathUpdated(T path) async {
    _cachedStates.removeWhere((e) => e.launchMode == LaunchMode.NoHistory);
    final launchMode = path.launchMode;
    if (launchMode == LaunchMode.MoveToTop)
      await _moveToTop(path);
    else if (launchMode == LaunchMode.DropToSingle)
      await _dropToSingle(path);
    else if (launchMode == LaunchMode.NoHistory) await _noHistory(path);
    print('path updated $_cachedStates');
  }

  Future<void> _moveToTop(T path) async {
    _cachedStates.removeWhere((e) => e == path);
    _cachedStates.add(path);
  }

  Future<void> _dropToSingle(T path) async {
    final lastIndex = _cachedStates.indexWhere((e) => e == path);

    if (lastIndex >= 0) {
      final newNavigation = _cachedStates.sublist(0, lastIndex + 1);
      _cachedStates.clear();
      _cachedStates.addAll(newNavigation);
    } else {
      _cachedStates.add(path);
    }
  }

  Future<void> _noHistory(T path) async {
    _cachedStates.add(path);
  }

  @override
  Future<void> navigateTo(T path) async {
    await _pathUpdated(path);
    notifyListeners();
  }
}

abstract class OpenNavigator<T extends NavigationBaseState> {
  Future<void> navigateTo(T path);
}
