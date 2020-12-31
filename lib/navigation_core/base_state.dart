enum LaunchMode { MoveToTop, DropToSingle, NoHistory }

abstract class NavigationBaseState {
  LaunchMode get launchMode;
}

class NavigatorDelegateState<S extends NavigationBaseState> {
  final List<S> _states;

  List<S> get states => _states.toList();

  get lastState => _states.last;

  NavigatorDelegateState(List<S> states) : _states = states ?? [];

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

  NavigatorDelegateState copyWith({
    List<S> states,
  }) {
    if ((states == null || identical(states, this._states))) {
      return this;
    }

    return NavigatorDelegateState(states ?? this._states);
  }

  NavigatorDelegateState clearNoHistory() =>
      copyWith(states: _states.where((e) => e.launchMode != LaunchMode.NoHistory).toList());

  NavigatorDelegateState<NavigationBaseState> addNewState(state) {
    final launchMode = state.launchMode;

    List<S> newStates;
    if (launchMode == LaunchMode.MoveToTop) {
      newStates = _moveToTop(state);
    } else if (launchMode == LaunchMode.DropToSingle) {
      newStates = _dropToSingle(state);
    } else if (launchMode == LaunchMode.NoHistory) {
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
