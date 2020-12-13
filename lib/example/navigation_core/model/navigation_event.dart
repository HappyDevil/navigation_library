import 'package:flutter/foundation.dart';

abstract class BookAppNavigationEvent {}

class NavigateToBook extends BookAppNavigationEvent {
  final int id;

  NavigateToBook({@required this.id});

  @override
  String toString() => 'NavigateToBook{id: $id}';
}
