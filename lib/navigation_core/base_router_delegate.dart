import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'base_state.dart';

abstract class BaseRouterDelegate<S extends NavigationBaseState, E>
    extends RouterDelegate<S>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<S>
    implements OpenNavigator<E> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final List<S> _cachedStates = [];

  @override
  S get currentConfiguration => _cachedStates.last;

  BaseRouterDelegate() {
    _cachedStates.add(initState());
  }

  @override
  Widget build(BuildContext context) {
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

  S initState();

  Page mapStateToPage(S state);

  S mapEventToState(E event);

  @override
  @protected
  Future<void> setNewRoutePath(S state) => _pathUpdated(state);

  Future<void> _pathUpdated(S state) async {
    _cachedStates.removeWhere((e) => e.launchMode == LaunchMode.NoHistory);
    final launchMode = state.launchMode;
    if (launchMode == LaunchMode.MoveToTop)
      await _moveToTop(state);
    else if (launchMode == LaunchMode.DropToSingle)
      await _dropToSingle(state);
    else if (launchMode == LaunchMode.NoHistory) await _noHistory(state);
  }

  Future<void> _moveToTop(S state) async {
    _cachedStates.removeWhere((s) => s == state);
    _cachedStates.add(state);
  }

  Future<void> _dropToSingle(S path) async {
    final lastIndex = _cachedStates.indexWhere((e) => e == path);

    if (lastIndex >= 0) {
      final newNavigation = _cachedStates.sublist(0, lastIndex + 1);
      _cachedStates.clear();
      _cachedStates.addAll(newNavigation);
    } else {
      _cachedStates.add(path);
    }
  }

  Future<void> _noHistory(S path) async {
    _cachedStates.add(path);
  }

  @override
  Future<void> navigate(E event) async {
    log("navigate event $event");
    final state = mapEventToState(event);
    log("navigate to state $state");
    await _pathUpdated(state);
    notifyListeners();
  }
}

abstract class OpenNavigator<E> {
  Future<void> navigate(E event);
}
