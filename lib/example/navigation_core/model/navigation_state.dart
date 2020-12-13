import 'package:navigation_library_impl/navigation_core/base_state.dart';

abstract class BookAppNavigationState implements NavigationBaseState {}

class NotFoundState extends BookAppNavigationState {
  @override
  LaunchMode get launchMode => LaunchMode.NoHistory;
}

class BookListState extends BookAppNavigationState {
  @override
  LaunchMode get launchMode => LaunchMode.DropToSingle;
}

class OpenBookState extends BookAppNavigationState {
  @override
  LaunchMode get launchMode => LaunchMode.MoveToTop;

  final int id;

  OpenBookState(this.id);

  @override
  String toString() {
    return 'OpenBookState{id: $id}';
  }
}
