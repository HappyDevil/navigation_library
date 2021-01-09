import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation_library_impl/navigation_core/model/base_state.dart';
import 'package:navigation_library_impl/navigation_core/navigator_infrastructure.dart';

abstract class BaseInformationParser<S extends NavigationBaseState> extends RouteInformationParser<S>
    with NavigatorInfrastructureMixin {
  @override
  @nonVirtual
  Future<S> parseRouteInformation(RouteInformation routeInformation) async {
    final newState = await parseRouteInformationInner(routeInformation);
    logWithTag('parsed new state($newState) from route information (${routeInformation.location})');
    return newState;
  }

  @override
  @nonVirtual
  RouteInformation restoreRouteInformation(S state) {
    final routeInformation = restoreRouteInformationInner(state);
    logWithTag('restored new route information(${routeInformation.location}) from state($state)');
    return routeInformation;
  }

  Future<S> parseRouteInformationInner(RouteInformation routeInformation);

  RouteInformation restoreRouteInformationInner(S state);
}
