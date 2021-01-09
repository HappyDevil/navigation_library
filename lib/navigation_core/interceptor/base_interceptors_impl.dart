import 'base_interceptor.dart';
import '../model/base_state.dart';

/**
 * [PS] - parent state ,
 * [CS] - child State
 */
class ParentChildStubStateConfigurator<PS extends NavigationBaseState, CS extends PS> extends StatesInterceptor<PS> {
  ParentChildStubStateConfigurator(this.buildNavigationStub);

  /**
   * Builder for StubState
   * The resulted [ChildNavigationStubState] must implement [PS], dart unsupported that generics feature
   */
  final ChildNavigationStubState Function(int startIndex, int endIndex) buildNavigationStub;

  @override
  List<PS> intercept(List<PS> states) {
    var firstCsIndex = -1;
    var navStubList = <ChildNavigationStubState>[];
    for (var indexedState in states.asMap().entries) {
      final index = indexedState.key;
      final state = indexedState.value;

      if (state is CS && firstCsIndex < 0) {
        firstCsIndex = index;
      } else if (firstCsIndex >= 0 && !(state is CS)) {
        navStubList.add(buildNavigationStub(firstCsIndex, index - 1));
        firstCsIndex = -1;
      }
    }

    if (firstCsIndex >= 0) {
      navStubList.add(buildNavigationStub(firstCsIndex, states.length - 1));
    }

    final statesCopy = states.toList();

    navStubList.forEach((e) {
      statesCopy.removeAt(e.startIndex);
      statesCopy.insert(e.startIndex, e as PS);
    });

    return statesCopy.where((s) => !(s is CS)).toList();
  }
}

class ChildStateCleaner<PS, CS> extends StatesInterceptor<PS> {
  ChildStateCleaner(this.childNavigationStubState);

  final ChildNavigationStubState childNavigationStubState;

  @override
  List<PS> intercept(List<PS> states) {
    return states.sublist(childNavigationStubState.startIndex, childNavigationStubState.endIndex + 1);
  }
}
