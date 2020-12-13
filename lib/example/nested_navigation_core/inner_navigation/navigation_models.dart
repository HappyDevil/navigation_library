import 'package:flutter/foundation.dart';
import 'package:navigation_library_impl/navigation_core/base_state.dart';

// states
abstract class BookAppNavigationState implements NavigationBaseState {}

class OpenBookState extends BookAppNavigationState {
  @override
  LaunchMode get launchMode => LaunchMode.MoveToTop;

  final int id;

  OpenBookState(this.id);

  @override
  String toString() => 'OpenBookState{id: $id}';
}

class BookListState extends BookAppNavigationState {
  @override
  LaunchMode get launchMode => LaunchMode.DropToSingle;
}

class NotFoundState extends BookAppNavigationState {
  @override
  LaunchMode get launchMode => LaunchMode.NoHistory;
}

//events

abstract class BookAppNavigationEvent {}

class NavigateToBook extends BookAppNavigationEvent {
  final int id;

  NavigateToBook({@required this.id});

  @override
  String toString() => 'NavigateToBook{id: $id}';
}
