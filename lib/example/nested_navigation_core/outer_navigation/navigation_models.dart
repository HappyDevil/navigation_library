import 'package:flutter/foundation.dart';
import 'package:navigation_library_impl/navigation_core/base_state.dart';

//states

abstract class OuterNavigationState extends NavigationBaseState {}

class SplashState extends OuterNavigationState {
  @override
  LaunchMode get launchMode => LaunchMode.NoHistory;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SplashState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class OuterNotFoundState extends OuterNavigationState {
  @override
  LaunchMode get launchMode => LaunchMode.NoHistory;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is OuterNotFoundState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class OuterLinkToInnerState extends OuterNavigationState {
  @override
  LaunchMode get launchMode => LaunchMode.NoHistory;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is OuterLinkToInnerState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
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
  final int newPageIndex;

  ChangeScreenEvent(this.newPageIndex);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeScreenEvent && runtimeType == other.runtimeType && newPageIndex == other.newPageIndex;

  @override
  int get hashCode => newPageIndex.hashCode;
}

class NavigateToBook extends OuterNavigationEvents {
  final int id;

  NavigateToBook({@required this.id});

  @override
  String toString() => 'NavigateToBook{id: $id}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NavigateToBook && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
