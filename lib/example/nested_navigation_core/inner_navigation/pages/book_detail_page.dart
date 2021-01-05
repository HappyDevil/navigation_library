import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/screens/book_details_screen.dart';
import 'package:navigation_library_impl/navigation_core/base_page.dart';

class BookDetailPage extends BasePage<OpenBookState> {
  BookDetailPage(OpenBookState state) : super(state);

  @override
  Route createRoute(BuildContext context) => MaterialPageRoute<dynamic>(
        settings: this,
        builder: (BuildContext context) {
          return BookDetailsScreen(book: state.id);
        },
      );
}