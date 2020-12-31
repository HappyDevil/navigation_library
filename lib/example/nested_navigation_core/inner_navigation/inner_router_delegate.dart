import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/pages/book_detail_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/pages/book_list_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/pages/inner_not_found_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/outer_router_delegate.dart';
import 'package:navigation_library_impl/navigation_core/base_router_delegate.dart';

class InnerRouterDelegate
    extends ChildBaseRouterDelegate<OuterNavigationState, InnerNavigationState, InnerNavigationEvents> {
  static InnerNavigationState initializeState() => BookListState();
  static InnerRouterDelegate I = InnerRouterDelegate._create();

  InnerRouterDelegate._create() : super(OuterRouterDelegate.I);

  int get currentBottomIndex => _resolveIndex(currentConfiguration);

  @override
  Page mapStateToPage(e) {
    if (e is OpenBookState) return BookDetailPage(e);
    if (e is BookListState) return BookListPage(e);
    return InnerNotFoundPage(e);
  }

  @override
  List<InnerNavigationState> initState() => [BookListState()];

  @override
  InnerNavigationState mapEventToState(final InnerNavigationEvents event) {
    if (event is DidUpdateWidgetEvent) return event.innerNavigationState;
    throw UnimplementedError("event type is not supports ${event.runtimeType}");
  }

  int _resolveIndex(final InnerNavigationState currentConfiguration) {
    if (currentConfiguration is OpenBookState || currentConfiguration is BookListState) return 0;
    return 1;
  }
}
