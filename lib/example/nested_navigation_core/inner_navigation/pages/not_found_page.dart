import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/inner_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/screens/unknown_screen.dart';
import 'package:navigation_library_impl/navigation_core/base_page.dart';

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