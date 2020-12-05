import 'package:equatable/equatable.dart';
import 'package:navigation_library_impl/navigation_core/base_state.dart';

abstract class AppNavigationState extends Equatable implements NavigationBaseState {
  @override
  bool get stringify => true;

  @override
  List<Object> get props => [];
}

class NotFoundState extends AppNavigationState {
  @override
  LaunchMode get launchMode => LaunchMode.NoHistory;
}

class BookListState extends AppNavigationState {
  @override
  LaunchMode get launchMode => LaunchMode.DropToSingle;
}

class OpenBookState extends AppNavigationState {
  @override
  LaunchMode get launchMode => LaunchMode.MoveToTop;

  final int id;

  OpenBookState(this.id);

  @override
  List<Object> get props => [id];
}
