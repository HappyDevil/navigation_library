import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'base_interceptor.dart';
import 'base_state.dart';

abstract class OpenNavigator<E> {
  Future<void> navigate(E event, {final bool withNotify = true});
}

abstract class BaseRouterDelegate<S extends NavigationBaseState, E> extends RouterDelegate<S>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<S>
    implements OpenNavigator<E> {
  BaseRouterDelegate({CompositeStatesInterceptor<S>? statesInterceptor}) {
    this.statesInterceptor = statesInterceptor ?? defaultInterceptor;
    _logTag = this.runtimeType.toString();
  }

  late final String _logTag;
  @protected
  late final CompositeStatesInterceptor<S> statesInterceptor;
  @protected
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @protected
  CompositeStatesInterceptor<S> get defaultInterceptor;

  @protected
  void popLast() {
    final states = navigatorState.states;
    states.removeLast();
    navigatorState = navigatorState.copyWith(states: states);
    notifyListeners();
  }

  @override
  S get currentConfiguration => navigatorState.lastState;

  @override
  Widget build(BuildContext context) {
    _innerLog('build $navigatorState');
    final states = navigatorState.states;
    return Navigator(
      key: navigatorKey,
      pages: statesInterceptor.intercept(states).map(mapStateToPage).whereType<Page>().toList(),
      onPopPage: popPage,
    );
  }

  @override
  @protected
  Future<void> setNewRoutePath(S state) => _pathUpdated(state, withNotify: true);

  @override
  Future<void> navigate(E event, {bool withNotify = true}) async {
    final state = mapEventToState(event);

    _innerLog('map event($event) To state($state) : notify($withNotify)');
    if (state != null) await _pathUpdated(state, withNotify: withNotify);
  }

  @protected
  bool popPage(Route<dynamic> route, dynamic result);

  @protected
  NavigatorDelegateState<S> get navigatorState;

  @protected
  set navigatorState(NavigatorDelegateState<S> navigatorDelegateState);

  @protected
  Page? mapStateToPage(S state);

  @protected
  S? mapEventToState(E event);

  Future<void> _pathUpdated(S state, {required bool withNotify}) async {
    navigatorState = navigatorState.clearNoHistory().addNewState(state);
    if (withNotify) notifyListeners();
  }

  void _innerLog(final String message) {
    log(message, name: _logTag);
  }
}