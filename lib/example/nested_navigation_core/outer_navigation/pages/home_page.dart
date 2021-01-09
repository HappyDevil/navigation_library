import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/screens/home_screen.dart';
import 'package:navigation_library_impl/navigation_core/navigator_infrastructure.dart';
import 'package:navigation_library_impl/navigation_core/page/base_page.dart';
import 'package:navigation_library_impl/example/nested_navigation_core/outer_navigation/navigation_models.dart';

class HomePage extends BasePage<OuterLinkToInnerState> with NavigatorInfrastructureMixin {
  HomePage(OuterLinkToInnerState state) : super(state, generateKey: false) {
    logWithTag('constructor $state');
  }

  @override
  Route createRoute(BuildContext context) {
    logWithTag('createRoute main page $state');
    return MaterialPageRoute<dynamic>(
      settings: this,
      builder: (context) {
        logWithTag('builder $state');
        return HomeScreen(outerLinkToInnerState: state);
      },
    );
  }
}
