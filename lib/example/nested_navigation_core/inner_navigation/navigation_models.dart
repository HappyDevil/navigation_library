import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';
import 'package:navigation_library_impl/navigation_core/model/base_launch_modes.dart';

mixin InnerNavigationState implements OuterNavigationState {}

class OpenBookState with InnerNavigationState {
  OpenBookState(this.id);

  @override
  LaunchMode get launchMode => MoveToTop();

  final int id;

  @override
  String toString() => 'OpenBookState{id: $id}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is OpenBookState && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class BookListState with InnerNavigationState {
  @override
  LaunchMode get launchMode => DropToSingle();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is BookListState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() {
    return 'BookListState{}';
  }
}

class InnerNotFoundState with InnerNavigationState {
  @override
  LaunchMode get launchMode => NoHistory();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is InnerNotFoundState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

//events

abstract class InnerNavigationEvents {}

class NavigateToBook extends InnerNavigationEvents {
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

class ChangeScreenEvent extends InnerNavigationEvents {
  ChangeScreenEvent(this.newPageIndex);

  final int newPageIndex;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeScreenEvent && runtimeType == other.runtimeType && newPageIndex == other.newPageIndex;

  @override
  int get hashCode => newPageIndex.hashCode;

  @override
  String toString() {
    return 'ChangeScreenEvent{newPageIndex: $newPageIndex}';
  }
}
