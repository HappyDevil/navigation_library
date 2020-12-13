import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/navigation_core/navigation/router_information_parser.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/outer_router_delegate.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/outer_router_information_parser.dart';

import 'inner_navigation/inner_router_delegate.dart';

class NestedNavigationApp extends StatelessWidget {
  final OuterRouterDelegate _routerDelegate = OuterRouterDelegate.I;
  final OuterRouteInformationParser _routeInformationParser = OuterRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NestedNavigationApp',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}