import 'package:navigation_library_impl/navigation_core/base_launch_modes.dart';
import 'package:navigation_library_impl/navigation_core/base_state.dart';

//states

abstract class OuterNavigationState extends NavigationBaseState {}

class SplashState extends OuterNavigationState {
  @override
  LaunchMode get launchMode => NoHistory();

  @override
  bool operator ==(Object other) => identical(this, other) || other is SplashState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class OuterNotFoundState extends OuterNavigationState {
  @override
  LaunchMode get launchMode => NoHistory();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is OuterNotFoundState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class OuterLinkToInnerState extends ChildNavigationStubState {
  OuterLinkToInnerState(int startIndex, int endIndex) : super(startIndex, endIndex);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OuterLinkToInnerState &&
          runtimeType == other.runtimeType &&
          startIndex == other.startIndex &&
          endIndex == other.endIndex;

  @override
  int get hashCode => startIndex.hashCode ^ endIndex.hashCode;
}

//events

abstract class OuterNavigationEvents {}

class NavigateToMainPage extends OuterNavigationEvents {
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NavigateToMainPage && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class ChangeScreenEvent extends OuterNavigationEvents {
  ChangeScreenEvent(this.newPageIndex);

  final int newPageIndex;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeScreenEvent && runtimeType == other.runtimeType && newPageIndex == other.newPageIndex;

  @override
  int get hashCode => newPageIndex.hashCode;
}

class NavigateToBook extends OuterNavigationEvents {
  NavigateToBook({required this.id});

  final int id;

  @override
  String toString() => 'NavigateToBook{id: $id}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NavigateToBook && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
