import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation_library_impl/navigation_core/navigator_infrastructure.dart';

import '../interceptor/base_interceptor.dart';
import '../model/base_state.dart';

abstract class OpenNavigator<E> {
  Future<void> navigate(E event);
  bool popPage(Route<dynamic> route, dynamic result);
}

abstract class BaseRouterDelegate<S extends NavigationBaseState, E> extends RouterDelegate<S>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<S>, NavigatorInfrastructureMixin
    implements OpenNavigator<E> {
  @protected
  CompositeStatesInterceptor<S> get statesInterceptor;

  @protected
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @protected
  void popLast() {
    final states = navigatorState.states;
    if (states.isNotEmpty) {
      states.removeLast();
      navigatorState = navigatorState.copyWith(states: states);
      notifyListeners();
    }
  }

  /**
   * Return the last navigation state of navigation
   * In [ChildBaseRouterDelegate] returns only inner navigation states
   * */
  S get lastState => navigatorState.lastState;

  /**
   * This is inner function for navigation logic, if you need to process last state of navigation use [lastState]
   * */
  @override
  @protected
  S? get currentConfiguration => lastState;

  @override
  Widget build(BuildContext context) {
    final states = navigatorState.states;
    final processedStates = statesInterceptor.intercept(states);
    final pages = processedStates.map(mapStateToPage).whereType<Page>().toList();
    logWithTag('build $states after processing $processedStates mapped to $pages');
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: popPage,
    );
  }

  @override
  @protected
  Future<void> setNewRoutePath(S state) {
    logWithTag('New route path generate new state $state');
    return _addNewState(state);
  }

  @override
  Future<void> navigate(E event) async {
    final states = await mapEventToStates(event);
    logWithTag('map event($event) To states $states');
    if (states != null) {
      await _addNewStates(states);
    }
  }

  @override
  @protected
  bool popPage(Route<dynamic> route, dynamic result) {
    logWithTag('popPage with result $result from route $route');
    popLast();
    return route.didPop(result);
  }

  @protected
  NavigatorDelegateState<S> get navigatorState;

  @protected
  set navigatorState(NavigatorDelegateState<S> navigatorDelegateState);

  @protected
  Page? mapStateToPage(S state);

  @protected
  Future<List<S>?> mapEventToStates(E event);

  Future<void> _addNewState(S state) async {
    final newNavigatorState = navigatorState.clearNoHistory().addNewState(state);
    if (navigatorState != newNavigatorState) {
      navigatorState = newNavigatorState;
      notifyListeners();
    }
  }

  Future<void> _addNewStates(List<S> states) async {
    final newNavigatorState = navigatorState.clearNoHistory().addNewStates(states);
    if (navigatorState != newNavigatorState) {
      navigatorState = newNavigatorState;
      notifyListeners();
    }
  }
}
