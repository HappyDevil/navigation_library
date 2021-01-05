abstract class StatesInterceptor<S> {
  List<S> intercept(final List<S> states);
}

class CompositeStatesInterceptor<S> implements StatesInterceptor<S> {
  CompositeStatesInterceptor({required List<StatesInterceptor<S>> interceptors})
      : interceptors = interceptors.toList(growable: false);

  final List<StatesInterceptor<S>> interceptors;

  @override
  List<S> intercept(List<S> states) => interceptors.fold(states, (states, int) => int.intercept(states));

  CompositeStatesInterceptor<S> copyWith({
    required List<StatesInterceptor<S>>? interceptors,
  }) {
    if ((interceptors == null || identical(interceptors, this.interceptors))) {
      return this;
    }

    return new CompositeStatesInterceptor(
      interceptors: interceptors,
    );
  }

  CompositeStatesInterceptor<S> plusComposite(final CompositeStatesInterceptor<S> interceptor) {
    return plusAll(interceptor.interceptors);
  }

  CompositeStatesInterceptor<S> plusAll(final List<StatesInterceptor<S>> interceptors) {
    final interceptorsCopy = this.interceptors.toList();
    interceptorsCopy.addAll(interceptors);
    return copyWith(interceptors: interceptorsCopy);
  }

  CompositeStatesInterceptor<S> plus(final StatesInterceptor<S> interceptor) {
    final interceptorsCopy = this.interceptors.toList();
    interceptorsCopy.add(interceptor);
    return copyWith(interceptors: interceptorsCopy);
  }
}
