import 'package:flutter/widgets.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/pages/main_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/pages/outer_not_found_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/pages/splash_page.dart';
import 'package:navigation_library_impl/navigation_core/base_router_delegate.dart';

class OuterRouterDelegate extends BaseRouterDelegate<OuterNavigationState, OuterNavigationEvents> {
  OuterRouterDelegate._create() : super();
  static final OuterRouterDelegate I = OuterRouterDelegate._create();

  @override
  OuterNavigationState initState() => SplashState();

  @override
  OuterNavigationState mapEventToState(final OuterNavigationEvents event) {
    if (event is NavigateToHome) return HomePageState();
    throw UnimplementedError("event type is not supports ${event.runtimeType}");
  }

  @override
  Page mapStateToPage(OuterNavigationState state) {
    if (state is SplashState) return SplashPage(state);
    if (state is OuterNotFoundState) return OuterNotFoundPage(state);
    if (state is HomePageState) return HomePage(state);
    throw UnimplementedError("state type is not supports ${state.runtimeType}");
  }
}
