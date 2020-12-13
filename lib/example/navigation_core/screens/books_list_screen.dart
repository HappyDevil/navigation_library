import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/navigation_core/model/data_provider.dart';
import 'package:navigation_library_impl/example/navigation_core/model/navigation_event.dart';
import 'package:navigation_library_impl/example/navigation_core/navigation/book_router_delegate.dart';

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
              onTap: () =>
                  BookRouterDelegate.I.navigate(NavigateToBook(id: book.id)),
            )
        ],
      ),
    );
  }
}
