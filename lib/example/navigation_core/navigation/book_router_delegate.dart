import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/navigation_core/model/navigation_event.dart';
import 'package:navigation_library_impl/example/navigation_core/model/navigation_state.dart';
import 'package:navigation_library_impl/example/navigation_core/navigation/pages/book_detail_page.dart';
import 'package:navigation_library_impl/example/navigation_core/navigation/pages/book_list_page.dart';
import 'package:navigation_library_impl/example/navigation_core/navigation/pages/not_found_page.dart';
import 'package:navigation_library_impl/navigation_core/base_router_delegate.dart';

class BookRouterDelegate extends BaseRouterDelegate<BookAppNavigationState, BookAppNavigationEvent> {
  BookRouterDelegate._create() : super();
  static final BookRouterDelegate I = BookRouterDelegate._create();

  @override
  Page mapStateToPage(e) {
    if (e is OpenBookState) return BookDetailPage(e);
    if (e is BookListState) return BookListPage(e);
    return NotFoundPage(e);
  }

  @override
  List<BookAppNavigationState> initState() => [BookListState()];

  @override
  BookAppNavigationState mapEventToState(final BookAppNavigationEvent event) {
    if (event is NavigateToBook) return OpenBookState(event.id);
    throw UnimplementedError("event type is not supports ${event.runtimeType}");
  }
}
