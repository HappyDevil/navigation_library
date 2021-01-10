import 'package:flutter/foundation.dart';
import 'package:navigation_library_impl/navigation_core/model/base_launch_modes.dart';

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
  LaunchMode get launchMode => VirtualState();

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

class NavigatorDelegateState<S extends NavigationBaseState> {
  NavigatorDelegateState({List<S> initStates = const []}) : _states = initStates.toList();

  final List<S> _states;

  List<S> get states => _states.toList();

  S get lastState => _states.last;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavigatorDelegateState && runtimeType == other.runtimeType && _states == other._states;

  @override
  int get hashCode => _states.hashCode;

  @override
  String toString() {
    return 'NavigatorDelegateState{_states: $_states}';
  }

  NavigatorDelegateState<S> copyWith({
    List<S>? states,
  }) {
    if ((states == null || identical(states, this._states))) {
      return this;
    }

    return NavigatorDelegateState(initStates: states);
  }

  NavigatorDelegateState<S> clearNoHistory() =>
      copyWith(states: _states.where((e) => !(e.launchMode is NoHistory)).toList());

  NavigatorDelegateState<S> addNewStates(List<S> states) {
    return states.fold(this, (delegateState, s) => delegateState.addNewState(s));
  }

  NavigatorDelegateState<S> addNewState(S state) {
    final launchMode = state.launchMode;

    List<S>? newStates;
    if (launchMode is MoveToTop) {
      newStates = _moveToTop(state);
    } else if (launchMode is DropToSingle) {
      newStates = _dropToSingle(state);
    } else if (launchMode is NoHistory) {
      newStates = _noHistory(state);
    }

    return copyWith(states: newStates);
  }

  List<S> _moveToTop(S state) {
    final newStates = _states.where((e) => e != state).toList();
    newStates.add(state);
    return newStates;
  }

  List<S> _dropToSingle(S path) {
    final lastIndex = _states.indexWhere((e) => e == path);

    if (lastIndex >= 0) {
      return _states.sublist(0, lastIndex + 1);
    } else {
      final newStates = _states.toList();
      newStates.add(path);
      return newStates;
    }
  }

  List<S> _noHistory(S path) {
    final newStates = _states.toList();
    newStates.add(path);
    return newStates;
  }
}
