import 'package:flutter/foundation.dart';

class BooksProvider {
  BooksProvider._create();

  static final BooksProvider I = BooksProvider._create();

  final books = List.generate(
    3,
    (index) => Book(
      id: index,
      title: index.toString(),
      author: index.toString(),
    ),
  );
}

class Book {
  final int id;
  final String title;
  final String author;

  Book({
    @required this.id,
    @required this.title,
    @required this.author,
  });
}
