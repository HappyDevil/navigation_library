import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/model/data_provider.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/outer_router_delegate.dart';

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
                onTap: () => OuterRouterDelegate.navigator.navigate(NavigateToBook(id: book.id)),
              ),
            )
            .toList(),
      ),
    );
  }
}
