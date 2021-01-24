import 'package:navigation_library_impl/navigation_core/model/base_state.dart';

/**
 * Interface that help to separate different
 * */
abstract class StatesStackMutator {
  /**
   * Method returns true if state will processed with this mutator, or false if not
   * */
  bool mutate<S extends NavigationBaseState>(List<S> states, S newState);
}
