import 'package:navigation_library_impl/navigation_core/domain/stack_mutators/states_stack_mutator.dart';
import 'package:navigation_library_impl/navigation_core/model/base_launch_modes.dart';
import 'package:navigation_library_impl/navigation_core/model/base_state.dart';

/**
 * Process states with launchMode [SingleMode]
 * */
class SingleModeMutator implements StatesStackMutator {
  const SingleModeMutator();

  @override
  bool mutate<S extends NavigationBaseState>(List<S> states, S newState) {
    if (newState.launchMode is! SingleMode) return false;
    final lastIndex = states.indexWhere((e) => e == newState);
    if (lastIndex >= 0) {
      states.removeRange(lastIndex, states.length);
    }
    return true;
  }
}

/**
 * Process states with launchMode [SingleTopMode]
 * */
class SingleTopModeMutator implements StatesStackMutator {
  const SingleTopModeMutator();

  @override
  bool mutate<S extends NavigationBaseState>(List<S> states, S newState) {
    if (newState.launchMode is! SingleTopMode) return false;
    states.removeWhere((s) => s == newState);
    return true;
  }
}

/**
 * Process states with launchMode [NoHistoryMode]
 * */
class NoHistoryModeMutator implements StatesStackMutator {
  const NoHistoryModeMutator();

  @override
  bool mutate<S extends NavigationBaseState>(List<S> states, S newState) {
    states.removeWhere((s) => s == newState);
    return true;
  }
}

/**
 * Process states with launchMode [VirtualStateMode]
 * */
class VirtualStateDefender implements StatesStackMutator {
  const VirtualStateDefender();

  @override
  bool mutate<S extends NavigationBaseState>(List<S> states, S newState) {
    final virtualIndex = states.indexWhere((s) => s is VirtualStateMode);
    if (virtualIndex >= 0) throw StateError('VirtualState contains into the stack on position ${virtualIndex}');
    return true;
  }
}
