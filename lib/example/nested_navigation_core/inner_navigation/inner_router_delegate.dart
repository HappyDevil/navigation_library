import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/pages/book_detail_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/pages/book_list_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/pages/inner_not_found_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/outer_router_delegate.dart';
import 'package:navigation_library_impl/navigation_core/base_router_delegate_impl.dart';

class InnerRouterDelegate extends ChildBaseRouterDelegate<OuterNavigationState, InnerNavigationState,
    OuterLinkToInnerState, InnerNavigationEvents> {
  InnerRouterDelegate(
    final OuterLinkToInnerState outerLinkToInnerState,
  ) : super(
          parentRouterDelegate: OuterRouterDelegate.I,
          childNavigationStubState: outerLinkToInnerState,
        );

  static InnerNavigationState initializeState() => BookListState();

  @override
  InnerNavigationState mapEventToState(final InnerNavigationEvents event) {
    if (event is DidUpdateWidgetEvent) return event.innerNavigationState;
    throw UnimplementedError('event type is not supported ${event.runtimeType}');
  }

  @override
  Page mapInnerStateToPage(InnerNavigationState state) {
    if (state is OpenBookState) return BookDetailPage(state);
    if (state is BookListState) return BookListPage(state);
    if (state is InnerNotFoundState) return InnerNotFoundPage(state);
    throw UnimplementedError('state is not supported ${state.runtimeType}');
  }

  int get currentBottomIndex => _resolveIndex(currentConfiguration);

  int _resolveIndex(final InnerNavigationState currentConfiguration) {
    if (currentConfiguration is OpenBookState || currentConfiguration is BookListState) return 0;
    return 1;
  }
}
