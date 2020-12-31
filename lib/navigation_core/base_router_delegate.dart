import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'base_state.dart';

abstract class OpenNavigator<E> {
  Future<void> navigate(E event, {final bool withNotify = true});
}

abstract class BaseRouterDelegate<S extends NavigationBaseState, E> extends RouterDelegate<S>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<S>
    implements OpenNavigator<E> {
  String _TAG;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @protected
  NavigatorDelegateState get navigatorState;

  @protected
  set navigatorState(NavigatorDelegateState navigatorDelegateState);

  BaseRouterDelegate() {
    _TAG = this.runtimeType.toString();
  }

  @override
  S get currentConfiguration => navigatorState.lastState;

  @override
  Widget build(BuildContext context) {
    _innerLog("build $navigatorState");
    final states = navigatorState.states;
    return Navigator(
      key: navigatorKey,
      pages: organize(states).map(mapStateToPage).toList(),
      onPopPage: popPage,
    );
  }

  @override
  @protected
  Future<void> setNewRoutePath(S state) => _pathUpdated(state);

  @override
  Future<void> navigate(E event, {bool withNotify = true}) async {
    _innerLog("navigate event $event");
    final state = mapEventToState(event);
    if (state != null) await _pathUpdated(state);
    if (withNotify) notifyListeners();
  }

  @protected
  bool popPage(Route<dynamic> route, dynamic result);

  @protected
  void popLast() {
    final states = navigatorState.states;
    states.removeLast();
    navigatorState = navigatorState.copyWith(states: states);
    notifyListeners();
  }

  @protected
  Page mapStateToPage(S state);

  @protected
  S mapEventToState(E event);

  @protected
  List<S> organize(List<S> cachedStates) => cachedStates;

  Future<void> _pathUpdated(S state) async {
    navigatorState = navigatorState.clearNoHistory().addNewState(state);
  }

  void _innerLog(final String message) {
    log(message, name: _TAG);
  }
}

abstract class ParentBaseRouterDelegate<S extends NavigationBaseState, E> extends BaseRouterDelegate<S, E> {
  NavigatorDelegateState _navigatorState;

  ParentBaseRouterDelegate() {
    _navigatorState = NavigatorDelegateState(initState());
  }

  @protected
  NavigatorDelegateState get navigatorState => _navigatorState;

  @protected
  set navigatorState(NavigatorDelegateState navigatorDelegateState) {
    _navigatorState = navigatorDelegateState;
  }

  @protected
  bool popPage(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) {
      return false;
    }
    popLast();
    return true;
  }

  List<S> initState();
}

abstract class ChildBaseRouterDelegate<PS extends NavigationBaseState, S extends PS, E>
    extends BaseRouterDelegate<S, E> {
  final BaseRouterDelegate<PS, dynamic> _parentRouterDelegate;

  @protected
  NavigatorDelegateState get navigatorState => _parentRouterDelegate.navigatorState;

  @protected
  set navigatorState(NavigatorDelegateState navigatorDelegateState) {
    _parentRouterDelegate.navigatorState = navigatorDelegateState;
  }

  ChildBaseRouterDelegate(this._parentRouterDelegate) {
    final newStates = navigatorState.states;
    newStates.addAll(initState());
    navigatorState = navigatorState.copyWith(states: newStates);
  }

  @override
  bool popPage(Route route, result) {
    popLast();
    return route.didPop(result);
  }

  @override
  void notifyListeners() {
    _parentRouterDelegate.notifyListeners();
    super.notifyListeners();
  }

  List<S> initState();
}
