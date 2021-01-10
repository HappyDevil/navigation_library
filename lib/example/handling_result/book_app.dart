import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/handling_result/navigation/router_information_parser.dart';

import 'navigation/book_router_delegate.dart';

class BooksApp extends StatelessWidget {
  final BookRouterDelegate _routerDelegate = BookRouterDelegate.I;
  final BookRouteInformationParser _routeInformationParser = BookRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Books App',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}