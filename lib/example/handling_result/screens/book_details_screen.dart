import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/handling_result/model/navigation_event.dart';
import 'package:navigation_library_impl/example/handling_result/navigation/book_router_delegate.dart';
import 'package:navigation_library_impl/example/handling_result/screens/enter_value_screen.dart';
import 'package:navigation_library_impl/navigation_core/model/result_model.dart';

class BookDetailsScreen extends StatelessWidget {
  BookDetailsScreen({
    required this.book,
  });

  final int book;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ResultModel>(
        stream: BookRouterDelegate.I.resultsByCode(EnterValueScreen.RESULT_CODE),
        builder: (context, snapshot) {
          final dynamic enteredText = snapshot.data?.result;
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.toString(), style: Theme.of(context).textTheme.headline6),
                  Text(book.toString(), style: Theme.of(context).textTheme.subtitle1),
                  Row(
                    children: [
                      Text('Entered text:'),
                      SizedBox(
                        width: 8,
                      ),
                      if (enteredText is String)
                        Text(
                          enteredText,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                  FlatButton(
                    onPressed: () => BookRouterDelegate.I.navigate(EnterValue()),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('EnterValue'),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
