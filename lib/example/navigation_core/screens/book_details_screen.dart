import 'package:flutter/material.dart';

class BookDetailsScreen extends StatelessWidget {
  BookDetailsScreen({
    required this.book,
  });

  final int book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.toString(), style: Theme.of(context).textTheme.headline6),
            Text(book.toString(), style: Theme.of(context).textTheme.subtitle1),
          ],
        ),
      ),
    );
  }
}
