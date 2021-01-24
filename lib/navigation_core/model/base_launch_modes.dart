abstract class LaunchMode {}

/**
 * Add state to top of the stack.
 * Example: (A,D,B,C) + D([DefaultMode]) -> (A,D,B,C,D)
 * */
class DefaultMode implements LaunchMode {}

/**
 * Add state to top of the stack, removes all occurrences of the old state onto the stack.
 * Example: (A,D,B,C) + D([SingleMode]) -> (A,B,C,D)
 * */
class SingleMode implements LaunchMode {}

/**
 * If state already exist in stack, deletes all states above the previous occurrence
 * Example: (A,D,B,C) + D([SingleTopMode]) -> (A,D); (A,B,C) + D(default) -> (A,B,C,D)
 * */
class SingleTopMode implements LaunchMode {}

/**
 * On the next adding state to the stack all states marked as NoHistory will removed
 * Example: (A,D([NoHistoryMode])) + B -> (A,B);
 * */
class NoHistoryMode implements LaunchMode {}

/**
 * States with this type add only with interceptor and not processed with navigationStackHandler
 */
class VirtualStateMode implements LaunchMode {}

/**
 * [LinkDirection.Before] Check the last state in the stack before adding state linked with another, if type of the
 * last state in the stack same as the type of linked state, the new state will adding to the
 * [LinkDirection.After] Check the last state in the state before adding state linked with another
 * Example: (A,D) + B -> (A,D,B);
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
