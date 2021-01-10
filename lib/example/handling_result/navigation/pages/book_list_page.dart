import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/handling_result/model/navigation_state.dart';
import 'package:navigation_library_impl/example/handling_result/screens/books_list_screen.dart';
import 'package:navigation_library_impl/navigation_core/page/base_page.dart';

class BookListPage extends BasePage<BookListState> {
  BookListPage(BookListState state) : super(state);

  @override
  Route createRoute(BuildContext context) => MaterialPageRoute<dynamic>(
        settings: this,
        builder: (BuildContext context) {
          return BooksListScreen();
        },
      );
}