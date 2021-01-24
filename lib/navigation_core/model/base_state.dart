import 'package:flutter/foundation.dart';
import 'package:navigation_library_impl/navigation_core/model/base_launch_modes.dart';

mixin NavigationBaseEvent {}

mixin NavigationBaseState {
  LaunchMode get launchMode;
}

abstract class ChildNavigationStubState with NavigationBaseState {
  /**
   * Indexes of child navigation three in main navigation stack
   */
  ChildNavigationStubState(this.startIndex, this.endIndex);

  final int startIndex;
  final int endIndex;

  int get length => (endIndex - startIndex) + 1;

  @override
  @nonVirtual
  LaunchMode get launchMode => VirtualStateMode();

  ChildNavigationStubState withNewIndex({
    int? startIndex,
    int? endIndex,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChildNavigationStubState &&
          runtimeType == other.runtimeType &&
          startIndex == other.startIndex &&
          endIndex == other.endIndex;

  @override
  int get hashCode => startIndex.hashCode ^ endIndex.hashCode;
}
