import 'package:flutter/widgets.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/inner_router_delegate.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/pages/main_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/pages/outer_not_found_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/pages/splash_page.dart';
import 'package:navigation_library_impl/navigation_core/base_router_delegate.dart';
import 'package:navigation_library_impl/navigation_core/base_router_delegate_impl.dart';

class OuterRouterDelegate extends ParentBaseRouterDelegate<OuterNavigationState, OuterNavigationEvents> {
  OuterRouterDelegate._create() : super();
  static final OuterRouterDelegate I = OuterRouterDelegate._create();
  static final OpenNavigator navigator = I;

  @override
  List<OuterNavigationState> get initState => [SplashState()];

  @override
  @protected
  OuterNavigationState mapEventToState(final OuterNavigationEvents event) {
    if (event is NavigateToMainPage) return InnerRouterDelegate.initializeState();
    if (event is NavigateToBook) return OpenBookState(event.id);
    if (event is ChangeScreenEvent) return _unresolveIndex(event.newPageIndex);
    throw UnimplementedError('event type is not supports ${event.runtimeType}');
  }

  @override
  @protected
  Page mapStateToPage(OuterNavigationState state) {
    if (state is SplashState) return SplashPage(state);
    if (state is OuterNotFoundState) return OuterNotFoundPage(state);
    if (state is OuterLinkToInnerState) return MainPage(state as OuterLinkToInnerState); //TODO fix it
    throw UnimplementedError('state type is not supports ${state.runtimeType}');
  }

  InnerNavigationState _unresolveIndex(final int newIndex) {
    switch (newIndex) {
      case 0:
        return BookListState();
    }
    return InnerNotFoundState();
  }
}
