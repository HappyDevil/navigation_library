import 'package:navigation_library_impl/navigation_core/model/base_launch_modes.dart';
import 'package:navigation_library_impl/navigation_core/model/base_state.dart';

mixin BookAppNavigationState implements NavigationBaseState {}

class NotFoundState with BookAppNavigationState {
  @override
  LaunchMode get launchMode => NoHistory();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NotFoundState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() {
    return 'NotFoundState{}';
  }
}

class BookListState with BookAppNavigationState {
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

class OpenBookState with BookAppNavigationState {
  OpenBookState(this.id);

  final int id;

  @override
  LaunchMode get launchMode => MoveToTop();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is OpenBookState && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'OpenBookState{id: $id}';
  }
}

class EnterValueState with BookAppNavigationState {
  @override
  LaunchMode get launchMode => MoveToTop();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is EnterValueState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() {
    return 'EnterValueState{}';
  }
}
