import 'package:navigation_library_impl/navigation_core/base_launch_modes.dart';
import 'package:navigation_library_impl/navigation_core/base_state.dart';

abstract class BookAppNavigationState implements NavigationBaseState {}

class NotFoundState extends BookAppNavigationState {
  @override
  LaunchMode get launchMode => NoHistory();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NotFoundState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BookListState extends BookAppNavigationState {
  @override
  LaunchMode get launchMode => DropToSingle();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is BookListState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class OpenBookState extends BookAppNavigationState {
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
