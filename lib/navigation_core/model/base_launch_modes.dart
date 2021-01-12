import 'package:navigation_library_impl/navigation_core/model/base_state.dart';

abstract class LaunchMode {}

/**
 * Add state to top of the stack.
 * Example: (A,D,B,C) + D([Default]) -> (A,D,B,C,D)
 * */
class Default implements LaunchMode {}

/**
 * Add state to top of the stack, removes all occurrences of the old state onto the stack.
 * Example: (A,D,B,C) + D([Single]) -> (A,B,C,D)
 * */
class Single implements LaunchMode {}

/**
 * If state already exist in stack, deletes all states above the previous occurrence
 * Example: (A,D,B,C) + D([EntryToTop]) -> (A,D); (A,B,C) + D(default) -> (A,B,C,D)
 * */
class EntryToTop implements LaunchMode {}

/**
 * On the next adding state to the stack all states marked as NoHistory will removed
 * Example: (A,D([NoHistory])) + B -> (A,B);
 * */
class NoHistory implements LaunchMode {}

/**
 * States with this type add only with interceptor and not processed with navigationStackHandler
 */
class VirtualState implements LaunchMode {}

/**
 * [LinkDirection.Before] Check the last state in the stack before adding state linked with another, if type of the
 * last state in the stack same as the type of linked state, the new state will adding to the
 * [LinkDirection.After] Check the last state in the state before adding state linked with another
 * Example: (A,D([NoHistory])) + B -> (A,B);
 * */
class LinkWithStates<Sub> implements LaunchMode {
  LinkWithStates({
    required this.linkedState,
    this.direction = LinkDirection.Before,
  });

  final Sub Function() linkedState;
  final LinkDirection direction;
  final Type linkedStateType = Sub;
}

enum LinkDirection {
  Before,
  After,
}
