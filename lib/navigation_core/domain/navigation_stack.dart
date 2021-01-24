import 'dart:async';

import 'package:navigation_library_impl/navigation_core/model/base_state.dart';

/**
 * Data class that represents current Navigation Three of application
 * [toMap] necessary to provide the ability to conduct analytics through external systems
 * Note: create NavigationStack only with StackBuilder, like StackBuilderDefault
 * */
abstract class NavigationStack<S extends NavigationBaseState> {
  /**
   * Return all states that contained into navigation stack
   * */
  List<S> get states;

  Map<String, dynamic> toMap();
}

class NavigationStackContainer<S extends NavigationBaseState> {
  NavigationStackContainer(this._cache);

  NavigationStack<S> _cache;
  StreamController<NavigationStack<S>> _navigationStreamController = StreamController.broadcast();

  Stream<NavigationStack<S>> get navigationChannel => _navigationStreamController.stream;

  NavigationStack<S> get navigationStack => _cache;

  void addState(final NavigationStack<S> newStack) {
    _navigationStreamController.add(newStack);
  }
}
