import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/fake_ioc_container.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/pages/book_detail_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/pages/book_list_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/pages/inner_not_found_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';
import 'package:navigation_library_impl/navigation_core/delegate/base_router_delegate_impl.dart';

class InnerRouterDelegate
    extends ChildBaseRouterDelegate<OuterNavigationState, InnerNavigationState, InnerNavigationEvents> {
  InnerRouterDelegate(
    final OuterLinkToInnerState outerLinkToInnerState,
  ) : super(
          parentRouterDelegate: FakeIcoContainer.parentRouter,
          childNavigationStubState: outerLinkToInnerState,
        );

  static InnerNavigationState initializeState() => BookListState();

  @override
  Future<InnerNavigationState> mapEventToState(final InnerNavigationEvents event) async {
    if (event is NavigateToBook) return OpenBookState(event.id);
    if (event is ChangeScreenEvent) return _unresolveIndex(event.newPageIndex);
    throw UnimplementedError('event type is not supported ${event.runtimeType}');
  }

  @override
  Page mapInnerStateToPage(InnerNavigationState state) {
    if (state is OpenBookState) return BookDetailPage(state);
    if (state is BookListState) return BookListPage(state);
    if (state is InnerNotFoundState) return InnerNotFoundPage(state);
    throw UnimplementedError('state is not supported ${state.runtimeType}');
  }

  int get currentBottomIndex => _resolveIndex(lastState);

  int _resolveIndex(final InnerNavigationState currentConfiguration) {
    if (currentConfiguration is OpenBookState || currentConfiguration is BookListState) return 0;
    return 1;
  }

  InnerNavigationState _unresolveIndex(final int newIndex) {
    switch (newIndex) {
      case 0:
        return BookListState();
    }
    return InnerNotFoundState();
  }
}
