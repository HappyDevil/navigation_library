import 'package:flutter/material.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/screens/splash_screen.dart';
import 'package:navigation_library_impl/navigation_core/base_page.dart';

class SplashPage extends BasePage<SplashState> {
  SplashPage(SplashState state) : super(state);

  @override
  Route createRoute(BuildContext context) => MaterialPageRoute(
        settings: this,
        builder: (context) => SplashScreen(),
      );
}
