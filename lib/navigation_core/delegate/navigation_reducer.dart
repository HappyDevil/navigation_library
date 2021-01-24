abstract class NavigationReducer {}

class NavigationReducerImpl implements NavigationReducer {

  /**
   * Stack add states synchronously and [_prevSynchronizedOperation] needed to run next [addNewState]
   * operation after result of the prev [addNewState] operation
   * */
  Future<void> _prevSynchronizedOperation = Future.value();

}
