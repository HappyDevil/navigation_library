import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/pages/book_detail_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/pages/book_list_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/pages/not_found_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/navigation_models.dart';
import 'package:navigation_library_impl/navigation_core/base_router_delegate.dart';

class InnerRouterDelegate extends BaseRouterDelegate<BookAppNavigationState, BookAppNavigationEvent> {
  InnerRouterDelegate._create() : super();
  static final InnerRouterDelegate I = InnerRouterDelegate._create();

  @override
  Page mapStateToPage(e) {
    if (e is OpenBookState) return BookDetailPage(e);
    if (e is BookListState) return BookListPage(e);
    return NotFoundPage(e);
  }

  @override
  BookAppNavigationState initState() => BookListState();

  @override
  BookAppNavigationState mapEventToState(final BookAppNavigationEvent event) {
    if (event is NavigateToBook) return OpenBookState(event.id);
    throw UnimplementedError("event type is not supports ${event.runtimeType}");
  }
}
