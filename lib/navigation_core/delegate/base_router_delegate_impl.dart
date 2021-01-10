import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../interceptor/base_interceptor.dart';
import '../interceptor/base_interceptors_impl.dart';
import 'base_router_delegate.dart';
import '../model/base_state.dart';

abstract class ParentBaseRouterDelegate<S extends NavigationBaseState, E> extends BaseRouterDelegate<S, E> {
  ParentBaseRouterDelegate({final CompositeStatesInterceptor<S>? statesInterceptor}) : super() {
    _navigatorState = NavigatorDelegateState(initStates: initState);
  }

  late NavigatorDelegateState<S> _navigatorState;

  @protected
  @nonVirtual
  NavigatorDelegateState<S> get navigatorState => _navigatorState;

  @protected
  @nonVirtual
  set navigatorState(NavigatorDelegateState<S> navigatorDelegateState) {
    _navigatorState = navigatorDelegateState;
  }

  @protected
  List<S> get initState;
}

/**
 * [PS] - parent navigation states, used as S in [ParentBaseRouterDelegate]
 * [CS] - child navigation states, used as main states type in [ChildBaseRouterDelegate]
 * [E] - events that processing by this router delegate
 * */
abstract class ChildBaseRouterDelegate<PS extends NavigationBaseState, CS extends PS, E>
    extends BaseRouterDelegate<PS, E> {
  /**
   * Interceptor are starts with [ChildStateCleaner] based on [childNavigationStubState] that's clear the from
   * state list the parent states (Not [CS] states)
   * */
  ChildBaseRouterDelegate({
    required this.parentRouterDelegate,
    required ChildNavigationStubState childNavigationStubState,
  }) : _childNavigationStubState = childNavigationStubState {
    _rebuildInnerInterceptor();
  }

  final ParentBaseRouterDelegate<PS, dynamic> parentRouterDelegate;
  ChildNavigationStubState _childNavigationStubState;
  late CompositeStatesInterceptor<PS> _innerInterceptor;

  @nonVirtual
  ChildNavigationStubState get childNavigationStubState => _childNavigationStubState;

  @protected
  @nonVirtual
  NavigatorDelegateState<PS> get navigatorState => parentRouterDelegate.navigatorState;

  @protected
  @nonVirtual
  set navigatorState(NavigatorDelegateState<PS> navigatorDelegateState) {
    parentRouterDelegate.navigatorState = navigatorDelegateState;
  }

  /**
   * Inner navigation must return null current configuration because it routerProvider and routerParser are null
   * */
  @override
  @nonVirtual
  @protected
  CS? get currentConfiguration => null;

  @override
  CS get lastState => (statesInterceptor.intercept(navigatorState.states).last as CS);

  @override
  @mustCallSuper
  @protected
  CompositeStatesInterceptor<PS> get statesInterceptor => _innerInterceptor;

  void _rebuildInnerInterceptor() {
    _innerInterceptor =
        CompositeStatesInterceptor<PS>(interceptors: [ChildStateCleaner<PS, CS>(_childNavigationStubState)]);
  }

  @override
  @nonVirtual
  Future<void> setNewRoutePath(PS state) {
    throw StateError("child delegate can't parse routes!");
  }

  @override
  @mustCallSuper
  Page? mapStateToPage(PS state) {
    if (state is CS)
      return mapInnerStateToPage(state);
    else {
      logWithTag('Not child type state - $state, was processed with child router delegate', logLevel: Level.warning);
      return null;
    }
  }

  @override
  @mustCallSuper
  void notifyListeners() {
    parentRouterDelegate.notifyListeners();
    // super.notifyListeners();
  }

  void didUpdateRouter(final ChildNavigationStubState childNavigationStubState) {
    if (childNavigationStubState != _childNavigationStubState) {
      logWithTag('router updated with new stub $childNavigationStubState');
      this._childNavigationStubState = childNavigationStubState;
      _rebuildInnerInterceptor();
      super.notifyListeners();
    }
  }

  @protected
  Page? mapInnerStateToPage(CS state);
}
