import 'package:flutter/material.dart';
import 'package:navigation_library_impl/navigation_core/base_page.dart';

import '../navigation_state.dart';

class BookDetailPage extends BasePage<OpenBookState> {
  BookDetailPage(OpenBookState state) : super(state);

  @override
  Route createRoute(BuildContext context) => MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) {
          return BookDetailsScreen(book: state.id);
        },
      );
}

class BookDetailsScreen extends StatelessWidget {
  final int book;

  BookDetailsScreen({
    @required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book != null) ...[
              Text(book.toString(), style: Theme.of(context).textTheme.headline6),
              Text(book.toString(), style: Theme.of(context).textTheme.subtitle1),
            ],
          ],
        ),
      ),
    );
  }
}
