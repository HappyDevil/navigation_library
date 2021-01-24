import 'package:flutter/foundation.dart';
import 'package:navigation_library_impl/navigation_core/domain/navigation_stack.dart';
import 'package:navigation_library_impl/navigation_core/domain/stack_builder/stack_builder.dart';
import 'package:navigation_library_impl/navigation_core/domain/stack_mutators/states_stack_mutator.dart';
import 'package:navigation_library_impl/navigation_core/model/base_state.dart';

/**
 * Default realization of [NavigationStack] building by [StackBuilderDefault]
 * */
class _NavigationStack<S extends NavigationBaseState> implements NavigationStack<S> {
  _NavigationStack(this.states);

  final List<S> states;

//<editor-fold desc="Data Methods" defaultstate="collapsed">
  @override
  String toString() {
    return '_NavigationStack{states: $states}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _NavigationStack && runtimeType == other.runtimeType && states == other.states);

  @override
  int get hashCode => states.hashCode;

  @override
  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'states': this.states,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}

/**
 * The implementation of [NavigationStackBuilder] that's processing the new state([S]) by its instance [NavigationBaseState.launchMode]
 * [NavigationStackBuilderDefault] based on delegation [addNewState] to the [StatesStackMutator], default instance of
 * [statesStackMutators] - list of delegates([StatesStackMutator]) for processing new state
 *
 * */
class NavigationStackBuilderDefault<S extends NavigationBaseState> implements NavigationStackBuilder<S> {
  NavigationStackBuilderDefault({
    required List<S> startStates,
    required this.statesStackMutators,
  }) : _states = startStates.toList();

  /**
   * Cache of list states that's was added to the result [NavigationStack]
   * */
  final List<S> _states;

  /**
   * On creating an insta§nce of [StatesStackDefault] it needed a list of delegates([StatesStackMutator])
   * */
  final List<StatesStackMutator> statesStackMutators;

  @override
  @nonVirtual
  void addNewState(S state) {
    for (final mutator in statesStackMutators) {
      mutator.mutate(_states, state);
    }
  }

  @override
  void applyStack(List<S> states) {
    _states.clear();
    _states.addAll(states);
  }

  @override
  void pop([int count = 1]) {
    _states.removeRange(_states.length - count, _states.length);
  }

  @override
  void popUntil(Type t) {
    final indexOfT = _states.indexWhere((s) => s.runtimeType == t);
    _states.removeRange((indexOfT >= 0) ? indexOfT + 1 : 0, _states.length);
  }

  @override
  NavigationStack<S> build() => _NavigationStack(_states.toList(growable: false));
}
