import 'package:flutter/src/widgets/navigator.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/fake_ioc_container.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/pages/inner_not_found_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';
import 'package:navigation_library_impl/navigation_core/delegate/base_router_delegate_impl.dart';

class FakeInnerDelegate
    extends ChildBaseRouterDelegate<OuterNavigationState, InnerNavigationState, InnerNavigationEvents> {
  FakeInnerDelegate(
    final OuterLinkToInnerState outerLinkToInnerState,
  ) : super(
          parentRouterDelegate: FakeIcoContainer.parentRouter,
          childNavigationStubState: outerLinkToInnerState,
        );

  @override
  Future<OuterNavigationState?> mapEventToState(InnerNavigationEvents event) async {
    return null;
  }

  @override
  Page? mapInnerStateToPage(InnerNavigationState state) {
    return InnerNotFoundPage(InnerNotFoundState());
  }
}
