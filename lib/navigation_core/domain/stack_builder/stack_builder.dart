import 'package:navigation_library_impl/navigation_core/domain/navigation_stack.dart';
import 'package:navigation_library_impl/navigation_core/domain/stack_builder/stack_builder_impl.dart';
import 'package:navigation_library_impl/navigation_core/domain/stack_mutators/mutators_impl.dart';
import 'package:navigation_library_impl/navigation_core/domain/stack_mutators/states_stack_mutator.dart';
import 'package:navigation_library_impl/navigation_core/model/base_state.dart';

/**
 * Builder class for [NavigationStack]
 * */
abstract class NavigationStackBuilder<S extends NavigationBaseState> {
  factory NavigationStackBuilder.defaultBuilder({
    List<S>? states,
    List<StatesStackMutator> statesStackMutators = const [
      const SingleModeMutator(),
      const SingleTopModeMutator(),
      const NoHistoryModeMutator(),
      const VirtualStateDefender(),
    ],
  }) =>
      NavigationStackBuilderDefault<S>(
        startStates: states ?? [],
        statesStackMutators: statesStackMutators,
      );

  /**
   * Replace builder cache with added [states]
   * */
  void applyStack(List<S> states);

  /**
   * Add new [state] to the stack
   * */
  void addNewState(S state);

  /**
   * Pop the set [count] of states from the stack
   * */
  void pop([int count = 1]);

  /**
   * Pop states from the stack until the state with type [t] is at the top
   * */
  void popUntil(Type t);

  /**
   * Build the result [NavigationStack]
   * */
  NavigationStack<S> build();
}
