import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/inner_router_delegate.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/pages/outer_not_found_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/pages/splash_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/screens/home_screen.dart';
import 'package:navigation_library_impl/navigation_core/delegate/base_router_delegate_impl.dart';
import 'package:navigation_library_impl/navigation_core/interceptor/base_interceptor.dart';
import 'package:navigation_library_impl/navigation_core/interceptor/base_interceptors_impl.dart';

class OuterRouterDelegate extends ParentBaseRouterDelegate<OuterNavigationState, OuterNavigationEvents> {
  @override
  List<OuterNavigationState> get initState => [SplashState()];

  @override
  CompositeStatesInterceptor<OuterNavigationState> get statesInterceptor => CompositeStatesInterceptor(
        interceptors: [
          ParentChildStubStateConfigurator<OuterNavigationState, InnerNavigationState>(
            (start, end) => OuterLinkToInnerState(start, end),
          ),
        ],
      );

  @override
  @protected
  Future<List<OuterNavigationState>> mapEventToStates(final OuterNavigationEvents event) async {
    if (event is NavigateToMainPage) return [InnerRouterDelegate.initializeState()];
    throw UnimplementedError('event type is not supports ${event.runtimeType}');
  }

  @override
  @protected
  Page mapStateToPage(OuterNavigationState state) {
    if (state is SplashState) return SplashPage(state);
    if (state is OuterNotFoundState) return OuterNotFoundPage(state);
    if (state is OuterLinkToInnerState) {
      return MaterialPage<dynamic>(
        child: HomeScreen(outerLinkToInnerState: state),
      );
    }
    throw UnimplementedError('state type is not supports ${state.runtimeType}');
  }
}
