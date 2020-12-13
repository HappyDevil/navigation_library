import 'package:navigation_library_impl/navigation_core/base_state.dart';

//states

abstract class OuterNavigationState extends NavigationBaseState {}

class SplashState extends OuterNavigationState {
  @override
  LaunchMode get launchMode => LaunchMode.NoHistory;
}

class OuterNotFoundState extends OuterNavigationState {
  @override
  LaunchMode get launchMode => LaunchMode.NoHistory;
}

class HomePageState extends OuterNavigationState {
  @override
  LaunchMode get launchMode => LaunchMode.DropToSingle;
}

//events

abstract class OuterNavigationEvents {}

class NavigateToHome extends OuterNavigationEvents {

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NavigateToHome && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
