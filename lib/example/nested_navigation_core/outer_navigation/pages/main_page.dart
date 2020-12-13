import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/screens/home_screen.dart';
import 'package:navigation_library_impl/navigation_core/base_page.dart';

class HomePage extends BasePage<HomePageState> {
  final HomePageState state;
  HomePage(this.state) : super(state);

  @override
  Route createRoute(BuildContext context) => MaterialPageRoute(
        settings: this,
        builder: (context) => HomeScreen(),
      );
}
