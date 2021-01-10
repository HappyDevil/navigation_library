import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/outer_router_delegate.dart';
import 'package:navigation_library_impl/navigation_core/delegate/base_router_delegate.dart';
import 'package:navigation_library_impl/navigation_core/delegate/open_navigator.dart';

// ignore: avoid_classes_with_only_static_members
class FakeIcoContainer {
  static final OuterRouterDelegate parentRouter = OuterRouterDelegate();
  static final OpenNavigator outerNavigator = parentRouter;

  /**
   * It must be provided with DI scope that created in HomeScreen graph level
   */
  static late OpenNavigator innerNavigator;
}
