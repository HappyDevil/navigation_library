import 'package:flutter/widgets.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';
import 'package:collection/collection.dart';
import 'package:navigation_library_impl/navigation_core/base_information_parser.dart';

class OuterRouteInformationParser extends BaseInformationParser<OuterNavigationState> {
  @override
  Future<OuterNavigationState> parseRouteInformationInner(RouteInformation routeInformation) async {
    final location = routeInformation.location;

    if (location != null) {
      final uri = Uri.parse(location);
      final pathSegments = uri.pathSegments;
      final length = pathSegments.length;

      //outer
      if (pathSegments.isEmpty) return SplashState();

      //inner
      final eq = const ListEquality<dynamic>().equals;

      if (eq(pathSegments, <String>['home', 'books'])) return BookListState();
      if (length == 3 && eq(pathSegments.sublist(0, 2), <String>['home', 'books'])) {
        final segment3 = int.tryParse(pathSegments[2]);
        return (segment3 != null) ? OpenBookState(segment3) : InnerNotFoundState();
      }
    }

    return OuterNotFoundState();
  }

  @override
  RouteInformation restoreRouteInformationInner(OuterNavigationState state) {
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
