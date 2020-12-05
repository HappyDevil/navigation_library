import 'package:flutter/material.dart';
import 'package:navigation_library_impl/navigation_core/base_page.dart';

import '../navigation_state.dart';

class NotFoundPage extends BasePage<NotFoundState> {
  NotFoundPage(NotFoundState state) : super(state);

  @override
  Route createRoute(BuildContext context) => MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) {
          return UnknownScreen();
        },
      );
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}
