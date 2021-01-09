import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/navigation_core/model/navigation_state.dart';
import 'package:navigation_library_impl/navigation_core/base_information_parser.dart';

class BookRouteInformationParser extends BaseInformationParser<BookAppNavigationState> {
  @override
  Future<BookAppNavigationState> parseRouteInformationInner(RouteInformation routeInformation) async {
    final location = routeInformation.location;
    if (location != null) {
      final uri = Uri.parse(location);
      // Handle '/'
      if (uri.pathSegments.length == 0) {
        return BookListState();
      }

      // Handle '/book/:id'
      if (uri.pathSegments.length == 2) {
        if (uri.pathSegments[0] != 'book') return NotFoundState();
        var remaining = uri.pathSegments[1];
        var id = int.tryParse(remaining);
        if (id == null) return NotFoundState();
        return OpenBookState(id);
      }
    }

    // Handle unknown routes
    return NotFoundState();
  }

  @override
  RouteInformation restoreRouteInformationInner(BookAppNavigationState path) {
    if (path is BookListState) {
      return RouteInformation(location: '/');
    }
    if (path is OpenBookState) {
      return RouteInformation(location: '/book/${path.id}');
    }
    return RouteInformation(location: '/404');
  }
}
