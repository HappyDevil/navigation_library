import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/fake_ioc_container.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/outer_router_information_parser.dart';

class NestedNavigationApp extends StatelessWidget {
  final OuterRouteInformationParser _routeInformationParser = OuterRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NestedNavigationApp',
      routerDelegate: FakeIcoContainer.parentRouter,
      routeInformationParser: _routeInformationParser,
    );
  }
}