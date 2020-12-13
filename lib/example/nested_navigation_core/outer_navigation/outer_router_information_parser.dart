import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';

class OuterRouteInformationParser extends RouteInformationParser<OuterNavigationState> {
  @override
  Future<OuterNavigationState> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    log(uri.path);
    if (uri.path == '/') return SplashState();
    if (uri.path == '/home') return HomePageState();
    return OuterNotFoundState();
  }

  @override
  RouteInformation restoreRouteInformation(OuterNavigationState state) {
    if (state is SplashState) {
      return RouteInformation(location: '/');
    }
    if (state is HomePageState) {
      return RouteInformation(location: '/home');
    }
    return RouteInformation(location: '/404');
  }
}
