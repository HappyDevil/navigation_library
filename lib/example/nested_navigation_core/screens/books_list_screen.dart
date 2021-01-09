import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/fake_ioc_container.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/model/data_provider.dart';

class BooksListScreen extends StatelessWidget {
  BooksListScreen();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: BooksProvider.I.books
          .map(
            (book) => ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () => FakeIcoContainer.innerNavigator.navigate(NavigateToBook(id: book.id)),
            ),
          )
          .toList(),
    );
  }
}
