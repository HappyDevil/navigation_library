import 'package:flutter/material.dart';

import 'navigation/navigation_state.dart';
import 'navigation/pages/book_detail_page.dart';
import 'navigation/pages/book_list_page.dart';
import 'navigation/pages/not_found_page.dart';
import 'navigation_core/base_router_delegate.dart';

void main() {
  runApp(BooksApp());
}

class Book {
  final int id;
  final String title;
  final String author;

  Book(this.id, this.title, this.author);
}

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

class BookRouteInformationParser extends RouteInformationParser<AppNavigationState> {
  @override
  Future<AppNavigationState> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
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

    // Handle unknown routes
    return NotFoundState();
  }

  @override
  RouteInformation restoreRouteInformation(AppNavigationState path) {
    if (path is BookListState) {
      return RouteInformation(location: '/');
    }
    if (path is OpenBookState) {
      return RouteInformation(location: '/book/${path.id}');
    }
    return RouteInformation(location: '/404');
  }
}

class BookRouterDelegate extends BaseRouterDelegate<AppNavigationState> {
  BookRouterDelegate._create() : super();
  static final BookRouterDelegate I = BookRouterDelegate._create();

  @override
  Page mapStateToPage(e) {
    if (e is OpenBookState) return BookDetailPage(e);
    if (e is BookListState) return BookListPage(e);
    return NotFoundPage(e);
  }

  @override
  AppNavigationState initState() => BookListState();
}

class BooksProvider {
  BooksProvider._create();
  static final BooksProvider I = BooksProvider._create();

  final books = List.generate(3, (index) => Book(index, index.toString(), index.toString()));
}
