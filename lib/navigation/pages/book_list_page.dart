import 'package:flutter/material.dart';
import 'package:navigation_library_impl/navigation_core/base_page.dart';

import '../../main.dart';
import '../navigation_state.dart';

class BookListPage extends BasePage<BookListState> {
  BookListPage(BookListState state) : super(state);

  @override
  Route createRoute(BuildContext context) => MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) {
          return BooksListScreen();
        },
      );
}

class BooksListScreen extends StatelessWidget {
  BooksListScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          for (var book in BooksProvider.I.books)
            ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () => BookRouterDelegate.I.navigateTo(OpenBookState(book.id)),
            )
        ],
      ),
    );
  }
}
