import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/inner_router_delegate.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/model/data_provider.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/navigation_models.dart';

class BooksListScreen extends StatelessWidget {
  BooksListScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: BooksProvider.I.books
            .map(
              (book) => ListTile(
                title: Text(book.title),
                subtitle: Text(book.author),
                onTap: () => InnerRouterDelegate.I.navigate(NavigateToBook(id: book.id)),
              ),
            )
            .toList(),
      ),
    );
  }
}
