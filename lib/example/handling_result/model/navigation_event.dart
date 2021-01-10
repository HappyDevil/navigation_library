abstract class BookAppNavigationEvent {}

class EnterValue extends BookAppNavigationEvent {
  @override
  String toString() {
    return 'EnterValue{}';
  }
}

class NavigateToBook extends BookAppNavigationEvent {
  NavigateToBook({required this.id});

  final int id;

  @override
  String toString() => 'NavigateToBook{id: $id}';
}
