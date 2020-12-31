import 'package:flutter/widgets.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/inner_router_delegate.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/pages/main_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/pages/outer_not_found_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/pages/splash_page.dart';
import 'package:navigation_library_impl/navigation_core/base_router_delegate.dart';

class OuterRouterDelegate extends ParentBaseRouterDelegate<OuterNavigationState, OuterNavigationEvents> {
  OuterRouterDelegate._create() : super();
  static final OuterRouterDelegate I = OuterRouterDelegate._create();
  static final OpenNavigator navigator = I;

  @override
  @protected
  List<OuterNavigationState> initState() => [SplashState()];

  @override
  @protected
  List<OuterNavigationState> organize(final List<OuterNavigationState> cachedStates) {
    final lastIndexOfInnerState = cachedStates.lastIndexWhere((e) => e is InnerNavigationState);
    if (lastIndexOfInnerState != -1) {
      return cachedStates
          .asMap()
          .entries
          .where((e) => e.key != lastIndexOfInnerState && e.value is InnerNavigationState)
          .map((e) => (e.value is InnerNavigationState) ? OuterLinkToInnerState() : e.value);
    } else {
      return cachedStates;
    }
  }

  @override
  @protected
  OuterNavigationState mapEventToState(final OuterNavigationEvents event) {
    if (event is NavigateToMainPage) return InnerRouterDelegate.initializeState();
    if (event is NavigateToBook) return OpenBookState(event.id);
    if (event is ChangeScreenEvent) return _unresolveIndex(event.newPageIndex);
    throw UnimplementedError("event type is not supports ${event.runtimeType}");
  }

  @override
  @protected
  Page mapStateToPage(OuterNavigationState state) {
    if (state is SplashState) return SplashPage(state);
    if (state is OuterNotFoundState) return OuterNotFoundPage(state);
    if (state is InnerNavigationState) return MainPage(state);
    throw UnimplementedError("state type is not supports ${state.runtimeType}");
  }

  InnerNavigationState _unresolveIndex(final int newIndex) {
    switch (newIndex) {
      case 0:
        return BookListState();
    }
    return InnerNotFoundState();
  }
}
