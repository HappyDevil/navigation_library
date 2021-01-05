import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'base_interceptor.dart';
import 'base_interceptors_impl.dart';
import 'base_router_delegate.dart';
import 'base_state.dart';

abstract class ParentBaseRouterDelegate<S extends NavigationBaseState, E> extends BaseRouterDelegate<S, E> {
  ParentBaseRouterDelegate({final CompositeStatesInterceptor<S>? statesInterceptor})
      : super(statesInterceptor: statesInterceptor) {
    _navigatorState = NavigatorDelegateState(initStates: initState);
  }

  late NavigatorDelegateState<S> _navigatorState;

  @override
  @protected
  @nonVirtual
  CompositeStatesInterceptor<S> get defaultInterceptor => CompositeStatesInterceptor(interceptors: []);

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

  @protected
  bool popPage(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) {
      return false;
    }
    popLast();
    return true;
  }
}

abstract class ChildBaseRouterDelegate<PS extends NavigationBaseState, CS extends PS,
    CsStub extends ChildNavigationStubState, E> extends BaseRouterDelegate<PS, E> {
  ChildBaseRouterDelegate({
    required this.parentRouterDelegate,
    required CsStub childNavigationStubState,
    CompositeStatesInterceptor<PS>? statesInterceptor,
  })  : _childNavigationStubState = childNavigationStubState,
        super(statesInterceptor: statesInterceptor);

  final BaseRouterDelegate<PS, dynamic> parentRouterDelegate;
  CsStub _childNavigationStubState;

  CsStub get childNavigationStubState => _childNavigationStubState;

  @protected
  @nonVirtual
  NavigatorDelegateState<PS> get navigatorState => parentRouterDelegate.navigatorState;

  @override
  CS get currentConfiguration => (statesInterceptor.intercept(navigatorState.states).last as CS);

  @override
  @protected
  @mustCallSuper
  CompositeStatesInterceptor<PS> get defaultInterceptor =>
      CompositeStatesInterceptor<PS>(interceptors: [ChildStateCleaner<PS, CS>(childNavigationStubState)]);

  @protected
  @nonVirtual
  set navigatorState(NavigatorDelegateState<PS> navigatorDelegateState) {
    parentRouterDelegate.navigatorState = navigatorDelegateState;
  }

  @override
  @mustCallSuper
  Page? mapStateToPage(PS state) {
    if (state is CS)
      return mapInnerStateToPage(state);
    else
      return null;
  }

  @override
  @mustCallSuper
  bool popPage(Route route, dynamic result) {
    popLast();
    return route.didPop(result);
  }

  @override
  @mustCallSuper
  void notifyListeners() {
    parentRouterDelegate.notifyListeners();
    super.notifyListeners();
  }

  void didUpdateRouter(final CsStub childNavigationStubState) {
    if (childNavigationStubState != _childNavigationStubState) {
      this._childNavigationStubState = childNavigationStubState;
      notifyListeners();
    }
  }

  @protected
  Page mapInnerStateToPage(CS state);
}
