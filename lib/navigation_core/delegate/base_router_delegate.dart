import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation_library_impl/navigation_core/delegate/open_navigator.dart';
import 'package:navigation_library_impl/navigation_core/domain/navigation_stack.dart';
import 'package:navigation_library_impl/navigation_core/domain/stack_builder/stack_builder.dart';
import 'package:navigation_library_impl/navigation_core/model/result_model.dart';
import 'package:navigation_library_impl/navigation_core/navigator_infrastructure.dart';

import '../interceptor/base_interceptor.dart';
import '../model/base_state.dart';

abstract class BaseRouterDelegate<S extends NavigationBaseState, E extends NavigationBaseEvent>
    extends RouterDelegate<NavigationStack<S>>
    with PopNavigatorRouterDelegateMixin<NavigationStack<S>>, NavigatorInfrastructureMixin
    implements OpenNavigator<E> {
  BaseRouterDelegate(List<S> initStates)
      : navigationStackContainer =
            NavigationStackContainer(NavigationStackBuilder<S>.defaultBuilder(states: initStates).build());

  @protected
  NavigationStackContainer<S> navigationStackContainer;

  @protected
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @protected
  final StreamController<ResultModel> resultsController = StreamController.broadcast();

  @override
  Stream<ResultModel> get results => resultsController.stream;

  @override
  Stream<ResultModel> resultsByCode(final String code) => resultsController.stream.where((r) => r.resultCode == code);

  /**
   * This is inner function for navigation logic, if you need to process last state of navigation use [lastState]
   * */
  @override
  @protected
  NavigationStack<S> get currentConfiguration => navigationStackContainer.navigationStack;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NavigationStack<S>>(
        stream: navigationStackContainer.navigationChannel,
        initialData: navigationStackContainer.navigationStack,
        builder: (context, snapshot) {
          final states = snapshot.data!.states;
          final processedStates = statesInterceptor.intercept(states);
          final pages = states.map(mapStateToPage).whereType<Page>().toList();
          logWithTag('build $states after processing $processedStates mapped to $pages');
          return Navigator(
            key: navigatorKey,
            pages: pages,
            onPopPage: popPage,
          );
        });
  }

  @override
  @protected
  Future<void> setNewRoutePath(NavigationStack<S> state) {}

  @override
  Future<void> navigate(E event) {}

  @protected
  bool popPage(Route<dynamic> route, dynamic result) {
    logWithTag('popPage from route $route');
    return pop(result: (result is ResultModel) ? result : null);
  }

  /**
   * Use [pop] method instead
   * */
  @override
  @deprecated
  Future<bool> popRoute() => super.popRoute();

  @override
  bool pop({ResultModel? result}) {
    logWithTag('pop with result $result');
    final states = navigationStackContainer.navigationStack.states;
    if (states.length > 1) {
      final navigationStack = (NavigationStackBuilder.defaultBuilder(states: states)..pop()).build();
      navigationStackContainer.addState(navigationStack);
      if (result != null) resultsController.add(result);
      return true;
    } else {
      return false;
    }
  }

  @override
  void addListener(VoidCallback listener) {
    navigationStackContainer.navigationChannel.listen((event) {});
  }

  @override
  void removeListener(VoidCallback listener) {}

  @protected
  CompositeStatesInterceptor<S> get statesInterceptor;

  @protected
  Page? mapStateToPage(S state);

  @protected
  Future<List<S>?> mapEventToStates(E event);
}
