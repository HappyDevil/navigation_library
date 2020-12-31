import 'package:flutter/foundation.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';
import 'package:navigation_library_impl/navigation_core/base_state.dart';

abstract class InnerNavigationState extends OuterNavigationState {}

class OpenBookState extends InnerNavigationState {
  @override
  LaunchMode get launchMode => LaunchMode.MoveToTop;

  final int id;

  OpenBookState(this.id);

  @override
  String toString() => 'OpenBookState{id: $id}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is OpenBookState && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class BookListState extends InnerNavigationState {
  @override
  LaunchMode get launchMode => LaunchMode.DropToSingle;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is BookListState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class InnerNotFoundState extends InnerNavigationState {
  @override
  LaunchMode get launchMode => LaunchMode.NoHistory;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is InnerNotFoundState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

//events

abstract class InnerNavigationEvents {}

class DidUpdateWidgetEvent extends InnerNavigationEvents {
  final InnerNavigationState innerNavigationState;

  DidUpdateWidgetEvent(this.innerNavigationState);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DidUpdateWidgetEvent &&
          runtimeType == other.runtimeType &&
          innerNavigationState == other.innerNavigationState;

  @override
  int get hashCode => innerNavigationState.hashCode;
}
