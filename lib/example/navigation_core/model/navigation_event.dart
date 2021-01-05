abstract class BookAppNavigationEvent {}

class NavigateToBook extends BookAppNavigationEvent {
  NavigateToBook({required this.id});
  final int id;

  @override
  String toString() => 'NavigateToBook{id: $id}';
}
