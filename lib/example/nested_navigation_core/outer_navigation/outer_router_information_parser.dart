import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';
import 'package:collection/collection.dart';

class OuterRouteInformationParser extends RouteInformationParser<OuterNavigationState> {
  @override
  Future<OuterNavigationState> parseRouteInformation(RouteInformation routeInformation) async {
    log(routeInformation.location);
    final uri = Uri.parse(routeInformation.location);
    final pathSegments = uri.pathSegments;
    final length = pathSegments.length;

    //outer
    if (pathSegments.isEmpty) return SplashState();


    //inner

    Function eq = const ListEquality().equals;

    if (eq(pathSegments, ['home', 'books'])) return BookListState();
    if (length == 3 && eq(pathSegments.sublist(0, 2), ['home', 'books'])) {
      final segment3 = int.tryParse(pathSegments[2]);
      return (segment3 != null) ? OpenBookState(segment3) : InnerNotFoundState();
    }

    return OuterNotFoundState();
  }

  @override
  RouteInformation restoreRouteInformation(OuterNavigationState state) {
    if (state is SplashState) {
      return RouteInformation(location: '/');
    }

    if (state is InnerNavigationState) {
      if (state is BookListState) {
        return RouteInformation(location: '/home/books');
      }
      if (state is OpenBookState) {
        return RouteInformation(location: '/home/books/${state.id}');
      }

      if (state is InnerNotFoundState) {
        return RouteInformation(location: '/home/404');
      }
    }

    return RouteInformation(location: '/404');
  }
}
